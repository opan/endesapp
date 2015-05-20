module Decrypted
  def dec_triple_des(opts = {})
    file              = opts[:file]
    key               = opts[:key]
    iv                = opts[:iv]
    folder_name       = ac_current_user.uniq_folder_name

    cipher            = OpenSSL::Cipher::Cipher.new("des3")
    cipher.decrypt

    cipher.key        = key
    cipher.iv         = iv

    dir_path          = "#{Rails.root.join('users',folder_name,'temp')}"
    file_path_temp    = File.join(dir_path, file.original_filename)

    ac_write_file(file, dir_path)

    file_temp         = File.open(file_path_temp)
    encrypted_content = file_temp.read

    encoded_content   = Base64.encode64(encrypted_content)

    cipher_text       = cipher.update(Base64.decode64(encoded_content))

    begin
      cipher_text       << cipher.final
      status          = "success"
      message         = "OK"
    rescue Exception => e
      status          = "danger"
      message         = e.message
    end

    ac_remove_file(dir_path)

    dir_path          = "#{Rails.root.join('users',folder_name,'decrypted','temp')}"
    file_name         = "decrypted_#{file.original_filename}"
    file_path_temp    = File.join(dir_path, file_name)

    unless Dir.exists?(dir_path)
      FileUtils.mkdir_p(dir_path)
    end

    File.open(file_path_temp, "wb") {|f| f.write(cipher_text)}

    result            = {
      :file_path => file_path_temp,
      :file_name => file_name,
      :message   => message,
      :status    => status
    }
  end
end