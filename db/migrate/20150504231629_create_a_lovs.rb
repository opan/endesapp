class CreateALovs < ActiveRecord::Migration
  def change
    create_table :a_lovs do |t|
      t.integer :lov_id, :limit => 8, :null => false
      t.string :lov_name, :limit => 50, :null => false
      t.string :lov_cat, :limit => 30, :null => false
      t.string :lov_parent, :limit => 8
      t.boolean :is_master_detail, :default => false, :null => false
      t.text :lov_params
      t.string :created_by, :string => 100, :null => false
      t.datetime :created_at, :null => false
      t.timestamps
    end
  end
end
