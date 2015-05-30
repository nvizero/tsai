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

ActiveRecord::Schema.define(version: 20150529151855) do

  create_table "accesses", force: true do |t|
    t.string   "title"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "status"
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
    t.integer  "type",       limit: 2
    t.string   "type_name",  limit: 30
  end

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "num"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "main",       limit: 40
    t.string   "code",       limit: 50
  end

  create_table "store_areas", primary_key: "area_id", force: true do |t|
    t.string   "area_name",  limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trades", force: true do |t|
    t.string   "description", limit: 60
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
    t.string   "forget_pas",      limit: 100
    t.text     "text"
    t.string   "trade_id",        limit: 2
    t.string   "store_area_id",   limit: 8
    t.string   "state",           limit: 1
    t.string   "username",        limit: 100
  end

end
