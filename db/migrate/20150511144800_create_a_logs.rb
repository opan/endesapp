class CreateALogs < ActiveRecord::Migration
  def change
    create_table :a_logs do |t|
      t.integer :user_id, null: false
      t.string :uniq_secure_session, null: false, limit: 100
      t.datetime :log_in_at
      t.datetime :log_out_at
      t.string :ip_client, limit: 50, null: false
      t.timestamps
    end
  end
end
