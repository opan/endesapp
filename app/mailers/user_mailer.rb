class UserMailer < ActionMailer::Base
  def send_email_file_and_key(opts = {}, current_user)
    file_path       = opts[:file_path]
    # @key            = Base64.encode64(opts[:key])
    # @iv             = Base64.encode64(opts[:iv])
    @key            = opts[:key]
    @iv             = opts[:iv]
    file_name       = opts[:file_name]

    @nickname       = current_user.nickname

    user_email      = %("#{current_user.fullname}" <#{current_user.username}>)
    subject         = "[Endesapp] File yang telah di enkripsi beserta Key enkripsi."

    attachments["#{file_name}"]      = File.read(file_path, encoding: "BINARY") 
    mail(to: user_email, subject: subject)
  end

  def send_email_only_key(opts = {}, current_user)
    @key            = opts[:key]
    @iv             = opts[:iv]
    @nickname       = current_user.nickname

    user_email      = %("#{current_user.fullname}" <#{current_user.username}>)
    subject         = "[Endesapp] Key dan Init Vektor."

    mail(to: user_email, subject: subject)
  end

  def send_email_file_decrypted(opts = {}, current_user)
    file_path       = opts[:file_path]
    file_name       = opts[:file_name]

    @nickname       = current_user.nickname
    user_email      = %("#{current_user.fullname}" <#{current_user.username}>)
    subject         = "[Endesapp] File yang telah di dekripsi."

    attachments["#{file_name}"]      = File.read(file_path, encoding: "BINARY") 
    mail(to: user_email, subject: subject)
  end
end