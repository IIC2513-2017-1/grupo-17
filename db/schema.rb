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

ActiveRecord::Schema.define(version: 20170627002451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alternatives", force: :cascade do |t|
    t.integer "field_id", null: false
    t.string  "value",    null: false
    t.index ["field_id"], name: "index_alternatives_on_field_id", using: :btree
  end

  create_table "bets", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "gee_id",     null: false
    t.integer  "quantity",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gee_id"], name: "index_bets_on_gee_id", using: :btree
    t.index ["user_id"], name: "index_bets_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "fields", force: :cascade do |t|
    t.integer "gee_id",        null: false
    t.string  "name",          null: false
    t.string  "ttype",         null: false
    t.integer "min_value"
    t.integer "max_value"
    t.integer "correct_value"
    t.index ["gee_id"], name: "index_fields_on_gee_id", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
    t.index ["user_id"], name: "index_friendships_on_user_id", using: :btree
  end

  create_table "gees", force: :cascade do |t|
    t.integer  "user_id",                            null: false
    t.integer  "category_id",                        null: false
    t.string   "name",                               null: false
    t.string   "description",     default: "",       null: false
    t.string   "state",           default: "opened", null: false
    t.boolean  "is_public",       default: true,     null: false
    t.datetime "expiration_date",                    null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["category_id"], name: "index_gees_on_category_id", using: :btree
    t.index ["user_id"], name: "index_gees_on_user_id", using: :btree
  end

  create_table "gees_users", id: false, force: :cascade do |t|
    t.integer "gee_id",  null: false
    t.integer "user_id", null: false
    t.index ["gee_id"], name: "index_gees_users_on_gee_id", using: :btree
    t.index ["user_id"], name: "index_gees_users_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                       null: false
    t.string   "description"
    t.string   "url"
    t.boolean  "read",        default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                            null: false
    t.string   "email",                               null: false
    t.string   "password_digest",                     null: false
    t.boolean  "is_admin",            default: false, null: false
    t.integer  "money",               default: 0,     null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "email_confirmed",     default: false
    t.string   "confirm_token"
    t.string   "api_token"
  end

  create_table "values", force: :cascade do |t|
    t.integer "bet_id",   null: false
    t.integer "field_id", null: false
    t.integer "value",    null: false
    t.index ["bet_id"], name: "index_values_on_bet_id", using: :btree
    t.index ["field_id"], name: "index_values_on_field_id", using: :btree
  end

  add_foreign_key "alternatives", "fields"
  add_foreign_key "bets", "gees"
  add_foreign_key "bets", "users"
  add_foreign_key "fields", "gees"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "gees", "categories"
  add_foreign_key "gees", "users"
  add_foreign_key "gees_users", "gees"
  add_foreign_key "gees_users", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "values", "bets"
  add_foreign_key "values", "fields"
end
