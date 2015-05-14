class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Encrypted #!/lib/endesapp/encrypted

  def ac_current_date
    return DateTime.now.strftime(DATETIME_FORMAT).to_time
  end

  protected

  def authenticate_user_login?
    if session[:uniq_user_session].blank? 
      redirect_to root_url
    end
  end

  def authenticate_user_session?
    unless session[:uniq_user_session].blank?
      a_users   = AUser.find(session[:user_id_session])
      flash[:notice] = "#{SUCCESS_SIGNIN}#{a_users.nickname}"

      redirect_to sistems_path
    end
  end
end
