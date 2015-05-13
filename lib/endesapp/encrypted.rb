module Encrypted
  def generate_salt
    BCrypt::Engine.generate_salt
  end

  def encrypt_password(str)
    BCrypt::Engine.hash_secret(str, generate_salt)
  end

  def generate_secure_string
    "#{SecureRandom.hex(15)}#{SecureRandom.base64}"
  end
end