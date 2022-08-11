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

ActiveRecord::Schema.define(version: 2022_08_11_041942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fullcourse_menus", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.integer "genre", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "menu_image"
    t.bigint "store_id", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "fullcourse_menus", "stores"
  add_foreign_key "fullcourse_menus", "users"
  add_foreign_key "fullcourses", "users"
end
