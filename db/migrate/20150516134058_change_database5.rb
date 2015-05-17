class ChangeDatabase5 < ActiveRecord::Migration
  def up
    add_column :m_encrypts, :hashed_keys, :text, null: false
    add_column :m_encrypts, :encrypted_keys, :text, null: false
    add_column :m_encrypts, :is_keep_file, :boolean, default: false
    add_column :m_encrypts, :is_custom_key, :boolean, default: false
    add_column :a_users, :uniq_folder_name, :string, limit: 100

  end

  def down
    remove_column :m_encrypts, :hashed_keys
    remove_column :m_encrypts, :encrypted_keys
    remove_column :m_encrypts, :is_keep_file
    remove_column :m_encrypts, :is_custom_key
    remove_column :a_users, :uniq_folder_name
  end
end
