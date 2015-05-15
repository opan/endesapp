class CreateMEncrypts < ActiveRecord::Migration
  def change
    create_table :m_encrypts do |t|
      t.integer :encrypt_id, limit: 8, null: false
      t.integer :ecnryption_type, null: false
      t.string :file_name, null: false
      t.string :created_by, null: false
      t.string :updated_by, null: false
      t.timestamps
    end
  end
end
