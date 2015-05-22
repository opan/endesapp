class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :ac_current_user
  include Encrypted,  #!/lib/endesapp/encrypted.rb
          Decrypted   #!/lib/endesapp/decrypted.rb

  def ac_current_date
    return DateTime.now.strftime(DATETIME_FORMAT).to_time
  end

  def ac_current_user
    AUser.find(session[:user_id_session])
  end

  def ac_counter_big_int(model, field)
    data      = model.maximum(field)

    if data.blank?
      result  = 1
    else
      result  = data.succ
    end
  end

  def ac_write_file(file_data, dir_path)
    name =  file_data.original_filename
    directory = dir_path
    # create the file path
    path = File.join(directory, name)

    unless Dir.exists?(directory)
      # Dir.mkdir(directory)
      FileUtils.mkdir_p(directory)
    end
    # write the file
    File.open(path, "wb") { |f| f.write(file_data.read) }
  end

  def ac_remove_file(dir_path)
    FileUtils.rm_rf(dir_path)
  end

  def ac_check_extfile(ext_file)
    if (ext_file == '.txt' || ext_file == '.TXT' || ext_file == '.csv' || ext_file == '.CSV' ||
        ext_file == '.text' || ext_file == '.pdf' || ext_file == '.PDF')
      true
    else
      false
    end
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
      flash[:success] = "#{SUCCESS_SIGNIN}#{a_users.nickname}"
      debugger
      redirect_to sistems_path
    end
  end
end
