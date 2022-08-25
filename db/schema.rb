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

ActiveRecord::Schema.define(version: 2022_08_24_075631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "fullcourse_menus", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.integer "genre", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "menu_image"
    t.bigint "store_id", null: false
    t.integer "level"
    t.index ["store_id"], name: "index_fullcourse_menus_on_store_id"
    t.index ["user_id"], name: "index_fullcourse_menus_on_user_id"
  end

  create_table "fullcourses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "fullcourse_image", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_fullcourses_on_user_id", unique: true
  end

  create_table "stars", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "fullcourse_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fullcourse_id"], name: "index_stars_on_fullcourse_id"
    t.index ["user_id", "fullcourse_id"], name: "index_stars_on_user_id_and_fullcourse_id", unique: true
    t.index ["user_id"], name: "index_stars_on_user_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "name", null: false
    t.integer "score", null: false
    t.integer "category", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_words_on_name", unique: true
  end

  add_foreign_key "fullcourse_menus", "stores"
  add_foreign_key "fullcourse_menus", "users"
  add_foreign_key "fullcourses", "users"
  add_foreign_key "stars", "fullcourses"
  add_foreign_key "stars", "users"
end
