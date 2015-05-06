# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150504231629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "a_lovs", force: true do |t|
    t.integer  "lov_id",           limit: 8,                  null: false
    t.string   "lov_name",         limit: 50,                 null: false
    t.string   "lov_cat",          limit: 30,                 null: false
    t.string   "lov_parent",       limit: 8
    t.boolean  "is_master_detail",            default: false, null: false
    t.text     "lov_params"
    t.string   "created_by",                                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "a_users", force: true do |t|
    t.string   "username",           limit: 100,             null: false
    t.string   "password",                                   null: false
    t.string   "encrypted_password",                         null: false
    t.string   "nickname",           limit: 100,             null: false
    t.string   "fullname",                                   null: false
    t.integer  "gender",                         default: 0, null: false
    t.date     "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
