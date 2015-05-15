class ChangeDatabase3 < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE m_encrypts DROP CONSTRAINT m_encrypts_pkey;
      ALTER TABLE m_encrypts
        ADD CONSTRAINT m_encrypts_pkey PRIMARY KEY(encrypt_id);
    SQL

    add_index :m_encrypts, :encrypt_id, unique: true
    add_column :m_encrypts, :username, :string, limit: 100, null: false
  end

  def down
    execute <<-SQL
      ALTER TABLE m_encrypts DROP CONSTRAINT m_encrypts_pkey;
      ALTER TABLE m_encrypts
        ADD CONSTRAINT m_encrypts_pkey PRIMARY KEY(id);
    SQL

    remove_index :m_encrypts, :encrypt_id
    remove_column :m_encrypts, :username
  end
end
