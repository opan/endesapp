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

ActiveRecord::Schema.define(version: 20150518231733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "a_logs", force: true do |t|
    t.integer  "user_id",                         null: false
    t.string   "uniq_secure_session", limit: 100, null: false
    t.datetime "log_in_at"
    t.datetime "log_out_at"
    t.string   "ip_client",           limit: 50,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "a_logs", ["id"], name: "index_a_logs_on_id", unique: true, using: :btree

  create_table "a_lovs", id: false, force: true do |t|
    t.integer  "id",                          default: "nextval('a_lovs_id_seq'::regclass)", null: false
    t.integer  "lov_id",           limit: 8,                                                 null: false
    t.string   "lov_name",         limit: 50,                                                null: false
    t.string   "lov_cat",          limit: 30,                                                null: false
    t.string   "lov_parent",       limit: 8
    t.boolean  "is_master_detail",            default: false,                                null: false
    t.text     "lov_params"
    t.string   "created_by",                                                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "a_lovs", ["lov_id"], name: "index_a_lovs_on_lov_id", unique: true, using: :btree

  create_table "a_users", id: false, force: true do |t|
    t.integer  "id",                             default: "nextval('a_users_id_seq'::regclass)", null: false
    t.string   "username",           limit: 100,                                                 null: false
    t.string   "password",                                                                       null: false
    t.string   "encrypted_password",                                                             null: false
    t.string   "nickname",           limit: 100,                                                 null: false
    t.string   "fullname",                                                                       null: false
    t.integer  "gender",                         default: 0,                                     null: false
    t.date     "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "login_count"
    t.string   "uniq_folder_name",   limit: 100
  end

  add_index "a_users", ["username"], name: "index_a_users_on_username", unique: true, using: :btree

  create_table "m_decrypts", id: false, force: true do |t|
    t.integer  "id",                          default: "nextval('m_decrypts_id_seq'::regclass)", null: false
    t.integer  "decrypt_id",      limit: 8,                                                      null: false
    t.string   "username",        limit: 100,                                                    null: false
    t.integer  "decryption_type",                                                                null: false
    t.string   "created_by",      limit: 100,                                                    null: false
    t.string   "updated_by",      limit: 100,                                                    null: false
    t.string   "file_name",                                                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "receive_type",    limit: 150,                                                    null: false
  end

  add_index "m_decrypts", ["decrypt_id"], name: "index_m_decrypts_on_decrypt_id", unique: true, using: :btree

  create_table "m_encrypts", id: false, force: true do |t|
    t.integer  "id",                          default: "nextval('m_encrypts_id_seq'::regclass)", null: false
    t.integer  "encrypt_id",      limit: 8,                                                      null: false
    t.integer  "encryption_type",                                                                null: false
    t.string   "file_name",                                                                      null: false
    t.string   "created_by",                                                                     null: false
    t.string   "updated_by",                                                                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",        limit: 100,                                                    null: false
    t.text     "hashed_keys",                                                                    null: false
    t.text     "encrypted_keys",                                                                 null: false
    t.boolean  "is_keep_file",                default: false
    t.boolean  "is_custom_key",               default: false
  end

  add_index "m_encrypts", ["encrypt_id"], name: "index_m_encrypts_on_encrypt_id", unique: true, using: :btree

end
