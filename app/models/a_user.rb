class AUser < ActiveRecord::Base
  self.table_name = "a_users"
  self.primary_key = :id
  # username, password, encrypted_password, nickname, fullname, 
  #      gender, birthdate, created_at, updated_at
  validates_uniqueness_of :username, message: "Username has been used. Please choose the other one."
  validates_presence_of :username, :password, :encrypted_password, :nickname, :fullname, 
                        :gender, :created_at, :updated_at
  validates_numericality_of :login_count, :message => "Only numbers allowed.", :allow_nil => true
  validates_confirmation_of :password, :message => "should match confirmation."
end
