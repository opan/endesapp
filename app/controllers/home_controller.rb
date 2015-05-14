class HomeController < ApplicationController
  before_action do |controller|
    controller.authenticate_user_session?
  end

  def index
    
  end

  def modal_signup
    @list_gender    = ALov.where(lov_cat: "gender_cat")
  end
end
