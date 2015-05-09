module Encrypted
  def generate_salt
    BCrypt::Engine.generate_salt
  end

  def encrypt_password(str)
    BCrypt::Engine.hash_secret(str, generate_salt)
  end
end