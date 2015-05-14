module Encrypted
  def generate_salt
    BCrypt::Engine.generate_salt
  end

  def encrypt_password(str)
    salt     = generate_salt
    result   = {enc_password: BCrypt::Engine.hash_secret(str, salt), salt: salt}
  end

  def generate_secure_string
    "#{SecureRandom.hex(15)}#{SecureRandom.base64}"
  end

  def authenticate_user(opts = {})
    a_user      = AUser.where(username: opts[:username]).take

    unless a_user.blank?
      if a_user.encrypted_password.eql? BCrypt::Engine.hash_secret(opts[:password], a_user.password)
        a_user
      end
    end
  end
end