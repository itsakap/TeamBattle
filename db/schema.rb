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

ActiveRecord::Schema.define(version: 20141217211126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "started?",   default: false
  end

  create_table "moves", force: true do |t|
    t.string   "move_choice", default: "defend"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "target"
  end

  add_index "moves", ["user_id"], name: "index_moves_on_user_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.boolean  "eliminated?", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
    t.boolean  "started?",    default: false
  end

  add_index "teams", ["game_id"], name: "index_teams_on_game_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.boolean  "captain?",        default: false
    t.boolean  "eliminated?",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "name"
    t.integer  "x",               default: 0
    t.integer  "y",               default: 0
    t.integer  "z",               default: 0
    t.integer  "team_id"
    t.integer  "hp"
    t.integer  "game_id"
  end

  add_index "users", ["game_id"], name: "index_users_on_game_id", using: :btree
  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree

end
