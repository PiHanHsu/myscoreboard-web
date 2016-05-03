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

ActiveRecord::Schema.define(version: 20160503034417) do

  create_table "cards", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.text     "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.string   "game_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "games", ["team_id"], name: "index_games_on_team_id"

  create_table "locations", force: :cascade do |t|
    t.string   "place_name"
    t.string   "address"
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "result"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "records", ["game_id"], name: "index_records_on_game_id"
  add_index "records", ["user_id"], name: "index_records_on_user_id"

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "day"
    t.time     "start_time",        default: '2000-01-01 00:00:00'
    t.time     "end_time",          default: '2000-01-01 00:00:00'
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "location_id",                                       null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "teams", ["location_id"], name: "index_teams_on_location_id"

  create_table "user_teamships", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "team_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_teamships", ["team_id"], name: "index_user_teamships_on_team_id"
  add_index "user_teamships", ["user_id"], name: "index_user_teamships_on_user_id"

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
    t.string   "gender"
    t.string   "photo"
    t.string   "fb_uid"
    t.string   "fb_token"
    t.string   "authentication_token"
    t.string   "fb_pic"
    t.text     "fb_raw_data"
    t.string   "email_first"
    t.string   "userid"
    t.string   "head_file_name"
    t.string   "head_content_type"
    t.integer  "head_file_size"
    t.datetime "head_updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
