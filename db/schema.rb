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

ActiveRecord::Schema.define(version: 20150812080558) do

  create_table "accesses", force: true do |t|
    t.string   "title"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",          limit: 1
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
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

  create_table "contactus", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "email"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "id_seqs", primary_key: "pre_id", force: true do |t|
    t.string   "seq"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
  end

  create_table "in_out_types", force: true do |t|
    t.string   "title"
    t.string   "cate"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "members", force: true do |t|
    t.string   "name"
    t.string   "tel"
    t.string   "address"
    t.string   "state"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "msgs", force: true do |t|
    t.string   "title",          limit: 100
    t.text     "content"
    t.string   "state",          limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "place",          limit: 50
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
  end

  create_table "order_by_products", force: true do |t|
    t.integer  "product_id"
    t.string   "code"
    t.integer  "num"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
    t.integer  "total"
    t.string   "product_code"
  end

  create_table "order_states", force: true do |t|
    t.string   "title"
    t.string   "state"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pay_types", force: true do |t|
    t.string   "code"
    t.string   "content"
    t.string   "state"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_in_outs", force: true do |t|
    t.integer  "product_id"
    t.string   "code"
    t.integer  "num"
    t.string   "in_or_out"
    t.string   "state",          limit: 2
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "in_out_type_id"
    t.string   "serial"
    t.string   "store_area_id"
    t.string   "level"
    t.date     "save_date"
    t.string   "is_finish",      limit: 2
    t.integer  "wait_order_id"
    t.string   "in_come_check",  limit: 2
  end

  create_table "product_orders", force: true do |t|
    t.string   "code"
    t.string   "order_state_id"
    t.integer  "member_id"
    t.string   "state"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "order_day"
    t.integer  "total"
    t.integer  "pay_type_id"
    t.date     "future_day"
    t.string   "confirm_order",  limit: 2
  end

  create_table "product_verifies", force: true do |t|
    t.integer  "product_id"
    t.string   "state"
    t.integer  "product_verify_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type",                    limit: 2
    t.string   "type_name",               limit: 30
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.integer  "product_verify_state_id"
  end

  create_table "product_verify_contents", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "file"
    t.string   "state",             limit: 2
    t.integer  "product_verify_id"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_verify_states", force: true do |t|
    t.string   "title"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.string   "state",          limit: 2
    t.datetime "stoped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
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
    t.string   "specification",       limit: 20
    t.integer  "one_base"
    t.integer  "one_heavy1"
    t.string   "one_heavy1_unit",     limit: 20
    t.integer  "one_heavy2"
    t.string   "one_heavy2_unit",     limit: 20
    t.string   "size"
    t.integer  "size1"
    t.integer  "size2"
    t.integer  "size3"
    t.string   "item_size"
    t.integer  "item_size1"
    t.integer  "item_size2"
    t.integer  "item_size3"
    t.string   "unit_save",           limit: 20
    t.string   "unit_support",        limit: 20
    t.integer  "ratio1"
    t.integer  "ratio2"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.string   "category",            limit: 20
    t.string   "form",                limit: 50
    t.string   "buy_batch",           limit: 20
    t.string   "affect_day",          limit: 50
    t.string   "head_date",           limit: 50
    t.string   "safe_save",           limit: 50
    t.string   "standard_store_area", limit: 50
    t.string   "income_unit",         limit: 50
    t.integer  "income_number"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
  end

  create_table "roles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "main",           limit: 40
    t.string   "code",           limit: 50
    t.string   "state",          limit: 1
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
  end

  create_table "store_areas", primary_key: "area_id", force: true do |t|
    t.string   "area_name",      limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",          limit: 1
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
  end

  create_table "trades", force: true do |t|
    t.string   "description",    limit: 60
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",          limit: 1
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
  end

  create_table "user_belongs", force: true do |t|
    t.integer  "user_id"
    t.integer  "belong_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
    t.string   "vip_access"
  end

  create_table "verify_type_mains", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",          limit: 1
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.datetime "stoped_at"
  end

  create_table "wait_orders", force: true do |t|
    t.integer  "product_id"
    t.string   "code"
    t.string   "num"
    t.string   "state"
    t.integer  "create_user_id"
    t.integer  "modify_user_id"
    t.integer  "stop_user_id"
    t.date     "stoped_at"
    t.string   "serial"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_order_code",  limit: 100
    t.string   "product_in_out_code", limit: 100
    t.integer  "price"
    t.integer  "total"
  end

end
