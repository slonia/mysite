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

ActiveRecord::Schema.define(version: 20140420120916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

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

  create_table "cathedras", force: true do |t|
    t.integer  "number"
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", force: true do |t|
    t.integer  "group_id"
    t.integer  "number",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "days", ["group_id"], name: "index_days_on_group_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name",                         null: false
    t.integer  "term",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "six_day_week", default: false, null: false
  end

  create_table "lessons", force: true do |t|
    t.integer  "number"
    t.boolean  "on_second_week", default: false, null: false
    t.boolean  "second_group",   default: false, null: false
    t.integer  "subject_id"
    t.integer  "teacher_id"
    t.integer  "room_id"
    t.string   "lesson_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_id",                         null: false
    t.boolean  "blank",          default: false, null: false
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

  create_table "tweet_logs", force: true do |t|
    t.string   "tweet_id",       null: false
    t.string   "full_text"
    t.hstore   "processed_text"
    t.string   "reply"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweet_logs", ["tweet_id"], name: "index_tweet_logs_on_tweet_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "image_url"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "twitter_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["twitter_id"], name: "index_users_on_twitter_id", using: :btree

end
