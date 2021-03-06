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

ActiveRecord::Schema.define(version: 20160419110231) do

  create_table "contributors", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "contributors", ["name"], name: "index_contributors_on_name", using: :btree

  create_table "package_contributors", force: :cascade do |t|
    t.integer  "package_id",        limit: 4, null: false
    t.integer  "contributor_id",    limit: 4, null: false
    t.integer  "contribution_type", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string   "name",         limit: 255,   null: false
    t.string   "version",      limit: 255
    t.string   "title",        limit: 255
    t.datetime "date"
    t.text     "description",  limit: 65535
    t.string   "dependencies", limit: 255
    t.string   "imports",      limit: 255
    t.string   "license",      limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "packages", ["name"], name: "index_packages_on_name", using: :btree

end
