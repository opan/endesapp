class ALov < ActiveRecord::Base
  self.table_name = "a_lovs"
  self.primary_key = :id
  # lov_id, lov_name, lov_cat, lov_parent, is_master_detail, 
  #      lov_params, created_by, created_at, updated_at

  validates_uniqueness_of :lov_id, messager: "Duplicate lov id."
  validates_presence_of :lov_id, :lov_name, :lov_cat,  
                        :created_by, :created_at, :updated_at
  validates_inclusion_of :is_master_detail, in: [true, false], if: :sm_default_value
  after_initialize :sm_default_value
  
  def sm_default_value
    self.is_master_detail ||= false
    true
  end
end
