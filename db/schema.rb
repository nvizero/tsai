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

ActiveRecord::Schema.define(version: 20150607035904) do

  create_table "accesses", force: true do |t|
    t.string   "title"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",      limit: 1
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "id_seqs", primary_key: "pre_id", force: true do |t|
    t.string   "seq"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "msgs", force: true do |t|
    t.string   "title",      limit: 100
    t.text     "content"
    t.string   "state",      limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "place",      limit: 50
  end

  create_table "product_verifies", force: true do |t|
    t.integer  "product_id"
    t.string   "state"
    t.integer  "product_verify_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type",                   limit: 2
    t.string   "type_name",              limit: 30
  end

  create_table "product_verify_types", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type",                limit: 2
    t.string   "type_name",           limit: 30
    t.integer  "verify_type_main_id", limit: 2
    t.string   "state",               limit: 1
  end

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "num"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "verify_type_main_id", limit: 2
    t.string   "state",               limit: 1
    t.string   "code",                limit: 10
    t.string   "model_no",            limit: 20
    t.string   "specification",       limit: 20
    t.integer  "one_base"
    t.integer  "one_heavy1"
    t.string   "one_heavy1_unit",     limit: 20
    t.integer  "one_heavy2"
    t.string   "one_heavy2_unit",     limit: 20
    t.integer  "size"
    t.integer  "size1"
    t.integer  "size2"
    t.integer  "size3"
    t.integer  "item_size"
    t.integer  "item_size1"
    t.integer  "item_size2"
    t.integer  "item_size3"
    t.string   "item_subject",        limit: 20
    t.string   "price_code",          limit: 20
    t.string   "control",             limit: 20
    t.string   "serial_code",         limit: 20
    t.string   "version",             limit: 20
    t.string   "item_style",          limit: 20
    t.string   "unit_save",           limit: 20
    t.string   "unit_support",        limit: 20
    t.string   "ratio1",              limit: 20
    t.string   "ratio2",              limit: 20
    t.integer  "create_users_id"
    t.integer  "modify_users_id"
    t.string   "party_material",      limit: 20
    t.string   "is_main",             limit: 2
    t.string   "category",            limit: 20
    t.string   "tax",                 limit: 20
    t.string   "less_rate",           limit: 20
    t.string   "adoption",            limit: 20
    t.string   "form",                limit: 50
    t.string   "firm",                limit: 50
    t.string   "buy_batch",           limit: 20
    t.string   "lost_rate",           limit: 20
    t.string   "abcd_category",       limit: 20
    t.string   "schedule",            limit: 20
    t.string   "business_unit",       limit: 20
    t.string   "produce_serial",      limit: 50
    t.string   "buy_unit",            limit: 20
    t.string   "tariff",              limit: 20
    t.string   "yield_rate",          limit: 20
    t.string   "packing_way",         limit: 20
    t.string   "recipientst_serial",  limit: 20
    t.string   "affect_day",          limit: 50
    t.string   "save_tax_date",       limit: 50
    t.string   "head_date",           limit: 50
    t.string   "buy_way",             limit: 50
    t.string   "keep_category",       limit: 50
    t.string   "test_level",          limit: 50
    t.string   "safe_save",           limit: 50
    t.string   "standard_store_area", limit: 50
    t.string   "virtual",             limit: 50
    t.string   "manage_code",         limit: 50
    t.string   "keep_tax",            limit: 50
    t.string   "store_code",          limit: 50
    t.string   "thing_code",          limit: 50
    t.string   "income_unit",         limit: 50
    t.string   "income_number",       limit: 50
    t.string   "income",              limit: 50
    t.integer  "check_year"
    t.integer  "check_month"
    t.integer  "check_day"
    t.integer  "alternate_number"
  end

  create_table "roles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "main",       limit: 40
    t.string   "code",       limit: 50
    t.string   "state",      limit: 1
  end

  create_table "store_areas", primary_key: "area_id", force: true do |t|
    t.string   "area_name",  limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",      limit: 1
  end

  create_table "trades", force: true do |t|
    t.string   "description", limit: 60
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",       limit: 1
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",         limit: 2
    t.string   "name",            limit: 60
    t.string   "boss",            limit: 20
    t.string   "serial_code",     limit: 20
    t.string   "tel",             limit: 20
    t.string   "company_address", limit: 80
    t.string   "send_address",    limit: 80
    t.string   "check_date",      limit: 45
    t.string   "password"
    t.string   "re_password"
    t.string   "prompt",          limit: 100
    t.text     "text"
    t.string   "trade_id",        limit: 2
    t.string   "store_area_id",   limit: 8
    t.string   "state",           limit: 1
    t.string   "username",        limit: 100
  end

  create_table "verify_type_mains", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",      limit: 1
  end

end
