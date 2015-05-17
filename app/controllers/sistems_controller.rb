class SistemsController < ApplicationController
  before_action :only => [:index] do |controller|
    controller.authenticate_user_login?
  end

  def index
  end

  def encrypt_form
    @list_enc_type    = ALov.where(lov_cat: "enc_type").order(:lov_id)

    render json: {encrypt_form: render_to_string(partial: "encrypt_form", locals: {list_enc_type: @list_enc_type, selected: 3})}
  end

  def decrypt_form
    @list_enc_type    = ALov.where(lov_cat: "enc_type").order(:lov_id)

    render json: {decrypt_form: render_to_string(partial: "decrypt_form", locals: {list_enc_type: @list_enc_type, selected: 3})}
  end

  def sign_in
    username        = params[:username_signin]
    password        = params[:password_signin]

    if password.present?
      opts          = {:username => username, :password => password}
      
      @a_user       = authenticate_user(opts)
      
      if @a_user
        session[:user_id_session]  = @a_user.id
        session[:uniq_user_session]= generate_secure_string

        create_user_log

        # update login_count 
        @a_user.login_count = @a_user.login_count.blank? ? 1  : @a_user.login_count.blank? + 1
        @a_user.save

        flash[:success] = "#{SUCCESS_SIGNIN}#{@a_user.nickname}"
        redirect_to sistems_path
      else
        flash[:error]   = INVALID_SIGNIN
        redirect_to root_path
      end  
    else
      flash[:error]     = PASS_BLANK
      redirect_to root_path
    end
  end

  def sign_out
    a_logs          = ALog.where(user_id: session[:user_id_session], uniq_secure_session: session[:uniq_user_session]).take

    if a_logs.update_attributes(
        updated_at: ac_current_date, 
        log_out_at: ac_current_date
      )
      @message      = SUCCESS_SIGNOUT

      session[:user_id_session]   = nil
      session[:uniq_user_session] = nil

      flash[:success] = @message
      redirect_to root_path
    else
      @message      = a_logs.errors.full_messages

      flash[:error] = @message
      redirect_to sistems_path
    end
  end

  def sign_up
    enc_password    = encrypt_password(params[:password])
    password        = enc_password[:salt]
    encrypt_password= enc_password[:enc_password]

    @a_user         = AUser.new(
                      username:           params[:username], 
                      password:           password, 
                      encrypted_password: encrypt_password, 
                      nickname:           params[:nickname], 
                      fullname:           params[:fullname], 
                      gender:             params[:gender], 
                      birthdate:          params[:birthdate], 
                      created_at:         ac_current_date, 
                      updated_at:         ac_current_date,
                      uniq_folder_name:   SecureRandom.hex(20)
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
