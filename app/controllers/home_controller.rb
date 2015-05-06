class HomeController < ApplicationController
  def index
    
  end

  def modal_signup
    @list_gender    = ALov.where(lov_cat: "gender_cat")
  end
end
