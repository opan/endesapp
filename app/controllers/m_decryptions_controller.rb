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
      @message          = UNPERMIT_EXTFILE_DEC           
    end

    case @decrypt_type
    when "3" # triple des
      if @status.eql? "success"
        @result         = dec_triple_des(@opts)

        if @result[:status].eql? "success"
          create_decrypt_log
        else
          @status         = @result[:status]
          @message        = "#{@result[:message]}. #{FAILED_DECRYPT}"
        end

      end
    end

    if ac_check_extfile(ext_file)
      render json: {status: @status, message: @message, path: @result[:file_path], file_name: @result[:file_name], 
                    receive_type: @receive_type}
    else
      render json: {status: @status, message: @message}
    end
  end

  def download_file
    cookies['fileDownload'] = 'true'

    file_path       = params[:path]
    file_name       = params[:file_name]

    file            = File.open(file_path)
    data            = file.read
    ac_remove_file(file_path)

    send_data(data, filename: file_name)
  end

  private

  def create_decrypt_log
    m_decrypts          = MDecrypt.new(
                            decrypt_id: ac_counter_big_int(MDecrypt, 'decrypt_id'), 
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

      email_gateway(@result)

    else
      @status           = "danger"
      @message          = m_decrypts.errors.full_messages
    end
  end

  def email_gateway(opts = {})
    if @receive_type.eql? "email"
      UserMailer.send_email_file_decrypted(opts, ac_current_user).deliver
      ac_remove_file(opts[:file_path])
    end
  end
end
