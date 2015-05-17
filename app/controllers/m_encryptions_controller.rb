class MEncryptionsController < ApplicationController
  before_action do |controller|
    controller.authenticate_user_login?
  end

  def encrypt_file
    enc_type            = params[:encryption_type]

    opts                = {
      :file         => params[:file_name],
      :is_keep_file => params[:is_keep_file],
      :custom_key   => params[:custom_key],
      :custom_iv    => params[:custom_iv],
      :is_custom_key=> params[:is_custom_key]
    }
    
    case enc_type
    when "3" # triple des
      enc_triple_des(opts)
    else

    end


    render json: {message: @message}
  end
end
