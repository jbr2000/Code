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

ActiveRecord::Schema.define(version: 20141018002009) do

  create_table "shifts", force: true do |t|
    t.integer  "user_id"
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "shifts", ["user_id"], name: "index_shifts_on_user_id"

  create_table "swaps", force: true do |t|
    t.integer  "owner_id"
    t.integer  "taker_id"
    t.integer  "shift_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "swaps", ["owner_id"], name: "index_swaps_on_owner_id"
  add_index "swaps", ["shift_id"], name: "index_swaps_on_shift_id"
  add_index "swaps", ["taker_id"], name: "index_swaps_on_taker_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
