class SistemsController < ApplicationController
  before_action :only => [:index] do |controller|
    controller.authenticate_user_login?
  end

  def index

  end

  def sign_in
    
  end

  def sign_out
    
  end

  def sign_up
    enc_password    = encrypt_password(params[:password])

    @a_user         = AUser.new(
                      username:           params[:username], 
                      password:           generate_salt, 
                      encrypted_password: enc_password, 
                      nickname:           params[:nickname], 
                      fullname:           params[:fullname], 
                      gender:             params[:gender], 
                      birthdate:          params[:birthdate], 
                      created_at:         ac_current_date, 
                      updated_at:         ac_current_date
                      )

    if @a_user.save
      @message      = "#{SUCCESS_SIGNUP}#{@a_user.nickname}"

      session[:user_id_session]  = @a_user.id
      session[:uniq_user_session]= generate_secure_string 
      create_user_log

      flash[:notice] = @message
      redirect_to sistems_path 
    else
      @message      = @a_user.errors.full_messages

      flash[:error] = @message
      redirect_to root_path
    end

  end

  private

  def create_user_log
    a_logs          = ALog.new(
                      user_id: @a_user.id, 
                      uniq_secure_session: session[:uniq_user_session], 
                      log_in_at: ac_current_date,  
                      ip_client: request.remote_ip, 
                      created_at: ac_current_date, 
                      updated_at: ac_current_date
                      )
    a_logs.save
  end
end
