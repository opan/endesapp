class ChangeDatabase5 < ActiveRecord::Migration
  def up
    add_column :m_encrypts, :hashed_key, :text, null: false
    add_column :m_encrypts, :encrypted_key, :text, null: false
    add_column :m_encrypts, :is_keep_file, :boolean, default: false
    add_column :m_encrypts, :is_custom_key, :boolean, default: false

  end

  def down
    remove_column :m_encrypts, :hashed_key
    remove_column :m_encrypts, :encrypted_key
    remove_column :m_encrypts, :is_keep_file
    remove_column :m_encrypts, :is_custom_key
  end
end
