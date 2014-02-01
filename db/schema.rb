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

ActiveRecord::Schema.define(version: 20140201103120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cathedras", force: true do |t|
    t.integer  "number"
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name",       null: false
    t.integer  "term",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", force: true do |t|
    t.integer  "day"
    t.integer  "number"
    t.boolean  "on_second_week"
    t.boolean  "second_group"
    t.integer  "subject_id"
    t.integer  "teacher_id"
    t.integer  "room_id"
    t.string   "lesson_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["room_id"], name: "index_lessons_on_room_id", using: :btree
  add_index "lessons", ["subject_id"], name: "index_lessons_on_subject_id", using: :btree
  add_index "lessons", ["teacher_id"], name: "index_lessons_on_teacher_id", using: :btree

  create_table "rooms", force: true do |t|
    t.string   "number",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "name",                    null: false
    t.integer  "terms",      default: [],              array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects_teachers", force: true do |t|
    t.integer "teacher_id"
    t.integer "subject_id"
  end

  create_table "teachers", force: true do |t|
    t.string   "surname",     null: false
    t.string   "name",        null: false
    t.string   "patronymic",  null: false
    t.string   "degree"
    t.integer  "cathedra_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teachers", ["cathedra_id"], name: "index_teachers_on_cathedra_id", using: :btree

end
