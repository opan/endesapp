class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Encrypted #!/lib/endesapp/encrypted

  def ac_current_date
    return DateTime.now.strftime(DATETIME_FORMAT).to_time
  end
end
