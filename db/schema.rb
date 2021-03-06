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

ActiveRecord::Schema.define(version: 20161218151335) do

  create_table "entries", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.text     "eye_catch_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "publish_date",                        null: false
    t.integer  "user_id"
    t.boolean  "published",           default: false, null: false
    t.index ["published"], name: "index_entries_on_published"
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_id"
    t.string   "image_filename"
    t.integer  "image_filesize"
    t.string   "image_content_type"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string   "screen_name"
    t.text     "description"
    t.string   "image_id"
    t.string   "image_filename"
    t.integer  "image_filesize"
    t.string   "image_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
