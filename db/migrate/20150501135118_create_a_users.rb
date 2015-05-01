class CreateAUsers < ActiveRecord::Migration
  def change
    create_table :a_users do |t|
      t.string :username, :limit => 100, null: false
      t.string :password, null: false
      t.string :encrypted_password, null: false
      t.string :nickname, :limit => 100, null: false
      t.string :fullname, null: false
      t.integer :gender , null: false, default: 0
      t.date :birthdate
      
      t.timestamps
    end
  end
end
