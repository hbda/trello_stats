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

ActiveRecord::Schema.define(version: 20141112095221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: true do |t|
    t.string   "trello_id",                  null: false
    t.boolean  "active",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "board_id"
  end

  add_index "boards_users", ["board_id"], name: "index_boards_users_on_board_id", using: :btree
  add_index "boards_users", ["user_id"], name: "index_boards_users_on_user_id", using: :btree

  create_table "statistics", force: true do |t|
    t.integer  "board_id"
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "name",                default: "", null: false
    t.string   "trello_uid",                       null: false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trello_token"
    t.string   "trello_secret"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["trello_uid"], name: "index_users_on_trello_uid", unique: true, using: :btree

end
