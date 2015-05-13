class ChangeDatabase1 < ActiveRecord::Migration
  def up
    add_column :a_users, :login_count, :integer
  end

  def down
    remove_column :a_users, :login_count
  end
end
