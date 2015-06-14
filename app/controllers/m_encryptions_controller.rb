class MEncryptionsController < ApplicationController
  before_action do |controller|
    controller.authenticate_user_login?
  end

  def encrypt_file
    enc_type            = params[:encryption_type]
    ext_file            = File.extname(params[:file_name].original_filename)
    @receive_type       = params[:receive_type]
    @status             = "success"

    @opts               = {
      :file         => params[:file_name],
      :is_keep_file => params[:is_keep_file],
      :custom_key   => params[:custom_key],
      :custom_iv    => params[:custom_iv],
      :is_custom_key=> params[:is_custom_key]
    }

    unless ac_check_extfile(ext_file)
      @status           = "danger"
      @message          = UNPERMIT_EXTFILE           
    end

    case enc_type
    when "3" # triple des
      if @status.eql? "success"
        @opts[:algo_type] = "des3"
        @result           = encryption_process(@opts)

        if @result[:status].eql? "success"
          create_encrypt_log
        else
          @status           = @result[:status]
          @message          = "#{@result[:message]}. #{FAILED_ENCRYPT}"
        end
      end
    when "4" # aes-128-cbc
      if @status.eql? "success"
        @opts[:algo_type] = "AES-128-CBC"
        @result           = encryption_process(@opts)

        if @result[:status].eql? "success"
          create_encrypt_log
        else
          @status           = @result[:status]
          @message          = "#{@result[:message]}. #{FAILED_ENCRYPT}"
        end
      end
    when "5" # AES-192-CBC
      if @status.eql? "success"
        @opts[:algo_type] = "AES-192-CBC"
        @result           = encryption_process(@opts)

        if @result[:status].eql? "success"
          create_encrypt_log
        else
          @status           = @result[:status]
          @message          = "#{@result[:message]}. #{FAILED_ENCRYPT}"
        end
      end
    when "6" # AES-256-CBC
      if @status.eql? "success"
        @opts[:algo_type] = "AES-256-CBC"
        @result           = encryption_process(@opts)

        if @result[:status].eql? "success"
          create_encrypt_log
        else
          @status           = @result[:status]
          @message          = "#{@result[:message]}. #{FAILED_ENCRYPT}"
        end
      end
    end

    if ac_check_extfile(ext_file)
      render json: {message: @message, status: @status, receive_type: @receive_type, path: @result[:file_path], 
                    file_name: @result[:file_name], keep_file: @result[:is_keep_file]
                  }
    else
      render json: {message: @message, status: @status, receive_type: @receive_type}
    end
  end

  def download_file
    cookies['fileDownload'] = 'true'

    file_path       = params[:path]
    file_name       = params[:file_name]
    keep_file       = params[:keep_file]

    if keep_file.eql?("true")
      send_file(file_path, filename: file_name)
    else
      file          = File.open(file_path)
      data          = file.read
      ac_remove_file(file_path)
      send_data(data, filename: file_name)
    end
  end

  private

  def email_gateway(opts = {}, receive_type)
    if receive_type.eql? "direct"
      UserMailer.send_email_only_key(opts, ac_current_user).deliver
    else
      UserMailer.send_email_file_and_key(opts, ac_current_user).deliver
    end

    if !opts[:is_keep_file] && @receive_type.eql?("email")
      ac_remove_file(opts[:file_path])
    end
  end

  def create_encrypt_log
    m_encrypts        = MEncrypt.new(
                          encrypt_id:       ac_counter_big_int(MEncrypt, 'encrypt_id'), 
                          encryption_type:  @opts[:enc_type].to_i, 
                          file_name:        params[:file_name].original_filename, 
                          created_by:       ac_current_user.username, 
                          updated_by:       ac_current_user.username, 
                          created_at:       ac_current_date, 
                          updated_at:       ac_current_date, 
                          username:         ac_current_user.username, 
                          hashed_keys:      @result[:hashed_keys].to_json, 
                          encrypted_keys:   @result[:encrypted_keys].to_json, 
                          is_keep_file:     @result[:is_keep_file], 
                          is_custom_key:    @result[:is_custom_key]
                      )

    if m_encrypts.save
      if @receive_type.eql? "direct"
        @message      = SUCCESS_ENCRYPT_WITH_DIRECT
      else
        @message      = SUCCESS_ENCRYPT_WITH_EMAIL
      end

      email_gateway(@result, @receive_type)
      @status         = "success"

    else
      @status         = "danger"
      @message        = m_encrypts.errors.full_messages
    end
  end
end
