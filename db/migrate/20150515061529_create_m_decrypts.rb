class CreateMDecrypts < ActiveRecord::Migration
  def change
    create_table :m_decrypts do |t|
      t.integer :decrypt_id, limit: 8, null: false
      t.string :username, limit: 100, null: false
      t.integer :decrption_type, null: false
      t.string :created_by, limit: 100, null: false
      t.string :updated_by, limit: 100, null: false
      t.string :file_name, null: false
      t.timestamps
    end
  end
end
