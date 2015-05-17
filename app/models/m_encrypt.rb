class MEncrypt < ActiveRecord::Base
  self.table_name = "m_encrypts"
  self.primary_key = :encrypt_id

  # encrypt_id, encryption_type, file_name, created_by, updated_by, 
  #      created_at, updated_at, username, hashed_key, :encrypted_key

  validates_uniqueness_of :encrypt_id
  validates_presence_of :encrypt_id, :encryption_type, :file_name, :created_by, :updated_by, 
                        :created_at, :updated_at, :username, :hashed_keys, :encrypted_keys

  validates_numericality_of :encryption_type
  # validates_inclusion_of :is_keep_file, :is_custom_key, :in =>
  after_initialize :sm_default_value

  def sm_default_value
    self.is_keep_file ||= false
    self.is_custom_key ||= false
  end 
end
