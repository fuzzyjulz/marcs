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

ActiveRecord::Schema.define(version: 20170801110011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "album_group",   null: false
    t.string   "title",         null: false
    t.datetime "last_modified"
    t.string   "url",           null: false
  end

  create_table "membership_fees", force: :cascade do |t|
    t.integer "year",                                null: false
    t.boolean "half_year",                           null: false
    t.string  "membership_type",                     null: false
    t.decimal "club_membership_fee",                 null: false
    t.decimal "insurance_fee",                       null: false
    t.boolean "new_member",          default: false, null: false
  end

  add_index "membership_fees", ["year", "half_year", "membership_type", "new_member"], name: "membership_fees_unique_key", unique: true, using: :btree

  create_table "membership_years", force: :cascade do |t|
    t.integer  "user_id",                                   null: false
    t.integer  "year",                                      null: false
    t.boolean  "half_year",                                 null: false
    t.string   "membership_type",                           null: false
    t.string   "pensioner_number"
    t.string   "student_number"
    t.boolean  "life_member",                               null: false
    t.boolean  "affiliate",                                 null: false
    t.string   "affiliated_club"
    t.boolean  "club_rules_accepted",                       null: false
    t.decimal  "total_fees"
    t.string   "payment_authorised_number"
    t.datetime "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed_paid"
    t.boolean  "new_member",                default: false, null: false
    t.integer  "batch"
  end

  add_index "membership_years", ["user_id", "year"], name: "index_membership_years_on_user_id_and_year", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "album_id",               null: false
    t.string   "google_id",              null: false
    t.string   "photo_url",              null: false
    t.string   "filename",               null: false
    t.string   "thumbnail_url"
    t.string   "mime_type",              null: false
    t.string   "file_extension",         null: false
    t.datetime "created_time",           null: false
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
  end

  create_table "user_wings", force: :cascade do |t|
    t.integer "user_id",   null: false
    t.string  "wing_type", null: false
    t.string  "rank",      null: false
  end

  add_index "user_wings", ["user_id", "wing_type"], name: "index_user_wings_on_user_id_and_wing_type", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fai"
    t.string   "financial"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "city"
    t.string   "postcode"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.boolean  "maaa_instructor"
    t.string   "club_instructor_type"
    t.string   "committee_position"
    t.string   "profile_image"
    t.string   "known_by"
    t.string   "membership_type"
    t.string   "affiliated_club"
    t.string   "pensioner_number"
    t.string   "student_number"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "membership_years", "users"
  add_foreign_key "photos", "albums"
end
