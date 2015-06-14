# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
p "Deleting all data on table a_lovs"
ALov.delete_all

p "Seeding table a_lovs with default values."
ALov.create!(lov_id: 1, lov_name: "Pria", lov_cat: "gender_cat", is_master_detail: false, created_by: "Endesapp", created_at: Date.today, updated_at: Date.today)
ALov.create!(lov_id: 2, lov_name: "Wanita", lov_cat: "gender_cat", is_master_detail: false, created_by: "Endesapp", created_at: Date.today, updated_at: Date.today)
ALov.create!(lov_id: 3, lov_name: "Triple Des", lov_cat: "enc_type", is_master_detail: false, created_by: "Endesapp", created_at: Date.today, updated_at: Date.today)
ALov.create!(lov_id: 4, lov_name: "AES-128-CBC", lov_cat: "enc_type", is_master_detail: false, created_by: "Endesapp", created_at: Date.today, updated_at: Date.today)
ALov.create!(lov_id: 5, lov_name: "AES-192-CBC", lov_cat: "enc_type", is_master_detail: false, created_by: "Endesapp", created_at: Date.today, updated_at: Date.today)
ALov.create!(lov_id: 6, lov_name: "AES-256-CBC", lov_cat: "enc_type", is_master_detail: false, created_by: "Endesapp", created_at: Date.today, updated_at: Date.today)