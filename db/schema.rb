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

ActiveRecord::Schema.define(version: 20150410191754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: true do |t|
    t.text     "name"
    t.float    "location_lng"
    t.float    "location_lat"
    t.text     "branch"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.text "name"
  end

  create_table "promos", force: true do |t|
    t.text     "lanacionid"
    t.integer  "business_id"
    t.integer  "category_id"
    t.text     "subcategory"
    t.text     "description"
    t.text     "card"
    t.text     "ptype"
    t.text     "date_from"
    t.text     "date_to"
    t.text     "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promos", ["business_id"], name: "index_promos_on_business_id", using: :btree
  add_index "promos", ["category_id"], name: "index_promos_on_category_id", using: :btree
  add_index "promos", ["lanacionid"], name: "index_promos_on_lanacionid", unique: true, using: :btree

end
