class ChangeDatabase4 < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER TABLE m_decrypts DROP CONSTRAINT m_decrypts_pkey;
      ALTER TABLE m_decrypts
        ADD CONSTRAINT m_decrypts_pkey PRIMARY KEY(decrypt_id);
    SQL

    add_index :m_decrypts, :decrypt_id, unique: true
    rename_column :m_decrypts, :decrption_type, :decryption_type
    rename_column :m_encrypts, :ecnryption_type, :encryption_type
  end

  def down
    execute <<-SQL
      ALTER TABLE m_decrypts DROP CONSTRAINT m_decrypts_pkey;
      ALTER TABLE m_decrypts
        ADD CONSTRAINT m_decrypts_pkey PRIMARY KEY(id);
    SQL

    remove_index :m_decrypts, :decrypt_id
    rename_column :m_decrypts, :decryption_type, :decrption_type
    rename_column :m_encrypts,  :encryption_type, :ecnryption_type
  end
end
