class UserMailer < ActionMailer::Base
  def send_email_file_and_key(opts = {}, current_user)
    file_path       = opts[:file_path]
    @key            = Base64.encode64(opts[:key])
    @iv             = Base64.encode64(opts[:iv])
    file_name       = opts[:file_name]

    @nickname       = current_user.nickname

    user_email      = %("#{current_user.fullname}" <#{current_user.username}>)
    subject         = "[Endesapp] File yang telah di enkripsi beserta Key enkripsi."
    debugger

    attachments["#{file_name}"]      = File.read(file_path, encoding: "BINARY") 
    mail(to: user_email, subject: subject)
  end

  def send_email_only_key
    
  end

end
