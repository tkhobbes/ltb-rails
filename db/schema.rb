# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_13_094236) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.integer "born"
    t.integer "died"
    t.string "nationality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_entries", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "story_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_entries_on_book_id"
    t.index ["story_id"], name: "index_book_entries_on_story_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "issue", null: false
    t.string "title", null: false
    t.integer "published"
    t.integer "pages", default: 0
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "story_id", null: false
    t.integer "task"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_roles_on_artist_id"
    t.index ["story_id"], name: "index_roles_on_story_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "code", null: false
    t.string "url"
    t.integer "published"
    t.string "origin"
    t.integer "pages", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "original_title"
  end

  add_foreign_key "book_entries", "books"
  add_foreign_key "book_entries", "stories"
  add_foreign_key "roles", "artists"
  add_foreign_key "roles", "stories"
end
