class MDecryptionsController < ApplicationController
  before_action do |controller|
    controller.authenticate_user_login?
  end

  def decrypt_file
    @decrypt_type       = params[:decryption_type]
    ext_file            = File.extname(params[:file_name].original_filename)
    @receive_type       = params[:receive_type]
    @status             = "success"

    @opts               = {
      :file         => params[:file_name],
      :key          => params[:key],
      :iv           => params[:iv]
    }

    unless ac_check_extfile(ext_file)
      @status           = "danger"
      @message          = UNPERMIT_EXTFILE           
    end

    case @decrypt_type
    when "3" # triple des
      if @status.eql? "success"
        @result         = dec_triple_des(@opts)
        create_decrypt_log
      end
    end

    render json: {status: @status, message: @message}
  end

  private

  def create_decrypt_log
    m_decrypts          = MDecrypt.new(
                          decrypt_id: ac_counter_big_int(MEncrypt, 'encrypt_id'), 
                          username:   ac_current_user.username, 
                          decryption_type: @decrypt_type.to_i, 
                          created_by: ac_current_user.username, 
                          updated_by: ac_current_user.username, 
                          file_name: params[:file_name].original_filename, 
                          created_at: ac_current_date, 
                          updated_at: ac_current_date, 
                          receive_type: @receive_type
                          )

    if m_decrypts.save
      @status           = "success"

      if @receive_type.eql? "email"
        @message          = SUCCESS_DECRYPT_WITH_EMAIL
      else
        @message          = SUCCESS_DECRYPT_WITH_DIRECT
      end


    else
      @status           = "danger"
      @message          = m_decrypts.errors.full_messages
    end
  end
end
