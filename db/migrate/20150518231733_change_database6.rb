class ChangeDatabase6 < ActiveRecord::Migration
  def up
    add_column :m_decrypts, :receive_type, :string, limit: 150, null: false
  end

  def down
    remove_column :m_decrypts, :receive_type
  end
end
