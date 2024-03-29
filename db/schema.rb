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

ActiveRecord::Schema.define(version: 20150411112139) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "apns_tokens", force: true do |t|
    t.text     "device_id"
    t.text     "apns_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apns_tokens", ["device_id"], name: "index_apns_tokens_on_device_id", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.text "name"
  end

  create_table "promos", force: true do |t|
    t.text     "lanacionid"
    t.integer  "category_id"
    t.float    "lat"
    t.float    "lon"
    t.text     "subcategory"
    t.text     "description"
    t.text     "card"
    t.text     "ptype"
    t.datetime "date_from"
    t.datetime "date_to"
    t.text     "image"
    t.integer  "business_id"
    t.text     "business_name"
    t.text     "business_branch"
    t.text     "business_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promos", ["category_id"], name: "index_promos_on_category_id", using: :btree
  add_index "promos", ["lanacionid"], name: "index_promos_on_lanacionid", unique: true, using: :btree

end
