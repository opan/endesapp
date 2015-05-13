class ChangeDatabase2 < ActiveRecord::Migration
  def up
    execute <<-SQL 
        ALTER TABLE a_users DROP CONSTRAINT a_users_pkey;
        ALTER TABLE a_users
        ADD CONSTRAINT a_users_pkey PRIMARY KEY(username);
        
        ALTER TABLE a_lovs DROP CONSTRAINT a_lovs_pkey;
        ALTER TABLE a_lovs
        ADD CONSTRAINT a_lovs_pkey PRIMARY KEY(lov_id);
    SQL

    add_index :a_users, :username, unique: true
    add_index :a_lovs, :lov_id, unique: true
    add_index :a_logs, :id, unique: true
  end

  def down
    execute <<-SQL 
        ALTER TABLE a_users DROP CONSTRAINT a_users_pkey;
        ALTER TABLE a_users
        ADD CONSTRAINT a_users_pkey PRIMARY KEY(id);

        ALTER TABLE a_lovs DROP CONSTRAINT a_lovs_pkey;
        ALTER TABLE a_lovs
        ADD CONSTRAINT a_lovs_pkey PRIMARY KEY(id);
    SQL

    remove_index :a_users, :username
    remove_index :a_lovs, :lov_id
    remove_index :a_logs, :id
  end
end
