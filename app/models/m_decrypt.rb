class MDecrypt < ActiveRecord::Base
  self.table_name = "m_decrypts"
  self.primary_key = :decrypt_id
  # decrypt_id, username, decryption_type, created_by, updated_by, 
  #      file_name, created_at, updated_at, receive_type

  validates_uniqueness_of :decrypt_id
  validates_presence_of :decrypt_id, :username, :decryption_type, :created_by, :updated_by, 
                        :file_name, :created_at, :updated_at, :receive_type

  validates_numericality_of :decryption_type
end
