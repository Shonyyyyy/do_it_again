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

ActiveRecord::Schema.define(version: 20160205111016) do

  create_table "annoyers", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "color",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "annoyers", ["user_id"], name: "index_annoyers_on_user_id", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "annoyer_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "nodes", ["annoyer_id"], name: "index_nodes_on_annoyer_id", using: :btree

  create_table "recents", force: :cascade do |t|
    t.integer  "reminder_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "recents", ["reminder_id"], name: "index_recents_on_reminder_id", using: :btree

  create_table "reminders", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "frequency",  limit: 4
    t.string   "repeat",     limit: 255
    t.integer  "annoyer_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "reminders", ["annoyer_id"], name: "index_reminders_on_annoyer_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",             limit: 255
    t.string   "crypted_password",  limit: 255
    t.string   "password_salt",     limit: 255
    t.string   "persistence_token", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "annoyers", "users"
  add_foreign_key "nodes", "annoyers"
  add_foreign_key "recents", "reminders"
  add_foreign_key "reminders", "annoyers"
end
