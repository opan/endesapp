class MEncryptionsController < ApplicationController
  before_action do |controller|
  end

  def encrypt_file
    
    render json: {message: @message}
  end
end
