class SistemsController < ApplicationController
  def index
  end

  def sign_in
    
  end

  def sign_up
    enc_password    = encrypt_password(str)
    a_user          = AUser.new(
                      username: params[:username], 
                      password: generate_salt, 
                      encrypted_password: enc_password, 
                      nickname: params[:nickname], 
                      fullname: params[:fullname], 
                      gender: params[:gender], 
                      birthdate: params[:birthdate], 
                      created_at: ac_current_date, 
                      updated_at: ac_current_date
                      )

    if a_user.save
      @message      = "#{SUCCESS_SIGNUP}#{a_user.username}"
    else
    end

    redirect_to root_path
  end
end
