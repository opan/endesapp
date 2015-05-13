class ALog < ActiveRecord::Base
  self.table_name = "a_logs"
  self.primary_key = :id

  validates_presence_of :ip_client, :user_id, :uniq_secure_session 
end
