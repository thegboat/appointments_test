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

ActiveRecord::Schema.define(version: 20140129044105) do

  create_table "appointments", force: true do |t|
    t.string "first_name", null: false
    t.string "last_name",  null: false
    t.string "start_time", null: false
    t.string "end_time",   null: false
    t.text   "comments"
  end

  add_index "appointments", ["end_time"], name: "index_appointments_on_end_time"
  add_index "appointments", ["first_name"], name: "index_appointments_on_first_name"
  add_index "appointments", ["last_name", "first_name"], name: "index_appointments_on_last_name_and_first_name"
  add_index "appointments", ["start_time"], name: "index_appointments_on_start_time"

end
