class MEncryptionsController < ApplicationController
  before_action do |controller|
    controller.authenticate_user_login?
  end

  def encrypt_file
    enc_type            = params[:encryption_type]
    ext_file            = File.extname(params[:file_name].original_filename)
    receive_type        = params[:receive_type]

    opts                = {
      :file         => params[:file_name],
      :is_keep_file => params[:is_keep_file],
      :custom_key   => params[:custom_key],
      :custom_iv    => params[:custom_iv],
      :is_custom_key=> params[:is_custom_key],
      :enc_type     => enc_type
    }

    case enc_type
    when "3" # triple des
      if check_extfile(ext_file)
        result            = enc_triple_des(opts)
        m_encrypts        = MEncrypt.new(
                            encrypt_id: ac_counter_big_int(MEncrypt, 'encrypt_id'), 
                            encryption_type: opts[:enc_type].to_i, 
                            file_name: params[:file_name].original_filename, 
                            created_by: ac_current_user.username, 
                            updated_by: ac_current_user.username, 
                            created_at: ac_current_date, 
                            updated_at: ac_current_date, 
                            username: ac_current_user.username, 
                            hashed_keys: result[:hashed_keys].to_json, 
                            encrypted_keys: result[:encrypted_keys].to_json, 
                            is_keep_file: result[:is_keep_file], 
                            is_custom_key: result[:is_custom_key]
                          )

        if m_encrypts.save
          if receive_type.eql? "direct"
            @message        = SUCCESS_ENCRYPT_WITH_DIRECT
          else
            @message        = SUCCESS_ENCRYPT_WITH_EMAIL
          end

          email_gateway(result, receive_type)
          @status         = "success"

        else
          @status         = "danger"
          @message        = m_encrypts.errors.full_messages
        end
      else
        @status           = "danger"
        @message          = UNPERMIT_EXTFILE           
      end
    end

    render json: {message: @message, status: @status, receive_type: receive_type}
  end

  private

  def check_extfile(ext_file)
    if (ext_file == '.txt' || ext_file == '.TXT' || ext_file == '.csv' || ext_file == '.CSV')
      true
    else
      false
    end
  end

  def email_gateway(opts = {}, receive_type)
    if receive_type.eql? "direct"
      UserMailer.send_email_only_key(opts, ac_current_user).deliver
    else
      UserMailer.send_email_file_and_key(opts, ac_current_user).deliver
    end

    if !opts[:is_keep_file]
      ac_remove_file(opts[:file_path])
    end
  end
end
