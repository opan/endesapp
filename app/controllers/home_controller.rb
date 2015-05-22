class HomeController < ApplicationController
  before_action do |controller|
    controller.authenticate_user_session?
  end

  def index
    
  end

  def modal_signup
    @list_gender    = ALov.where(lov_cat: "gender_cat")

    render json: {signup: render_to_string(partial: "modal_signup", locals: {list_gender: @list_gender})}
  end

  def modal_signin
    render json: {signin: render_to_string(partial: "modal_signin")}
  end
end
