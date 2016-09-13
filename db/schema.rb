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

ActiveRecord::Schema.define(version: 20160710074200) do

  create_table "cards", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.text     "topic",      limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "team_id",    limit: 4,   null: false
    t.string   "game_type",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "games", ["team_id"], name: "index_games_on_team_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "place_name",      limit: 255, default: ""
    t.string   "address",         limit: 255
    t.string   "lat",             limit: 255
    t.string   "lng",             limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "google_place_id", limit: 255
  end

  create_table "records", force: :cascade do |t|
    t.integer  "game_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "result",     limit: 255
    t.integer  "score",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "records", ["game_id"], name: "index_records_on_game_id", using: :btree
  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "day",               limit: 255, default: ""
    t.time     "start_time",                    default: '2000-01-01 00:00:00'
    t.time     "end_time",                      default: '2000-01-01 00:00:00'
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.integer  "location_id",       limit: 4
  end

  create_table "user_teamships", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "team_id",    limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_teamships", ["team_id"], name: "index_user_teamships_on_team_id", using: :btree
  add_index "user_teamships", ["user_id"], name: "index_user_teamships_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "username",               limit: 255
    t.string   "gender",                 limit: 255
    t.string   "photo",                  limit: 255
    t.string   "fb_uid",                 limit: 255
    t.string   "fb_token",               limit: 255
    t.string   "authentication_token",   limit: 255
    t.string   "fb_pic",                 limit: 255
    t.text     "fb_raw_data",            limit: 65535
    t.string   "email_first",            limit: 255
    t.string   "userid",                 limit: 255
    t.string   "head_file_name",         limit: 255
    t.string   "head_content_type",      limit: 255
    t.integer  "head_file_size",         limit: 4
    t.datetime "head_updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
