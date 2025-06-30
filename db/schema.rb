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

ActiveRecord::Schema[8.0].define(version: 2025_06_28_135102) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.date "date", null: false
    t.time "time", null: false
    t.integer "total_slots", default: 16, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "battery_id", null: false
    t.index ["battery_id"], name: "index_availabilities_on_battery_id"
    t.index ["date", "time", "battery_id"], name: "index_availabilities_on_date_time_battery", unique: true
  end

  create_table "batteries", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.bigint "user_id", null: false
    t.integer "slot_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "availability_id", null: false
    t.integer "payment_status", default: 0, null: false
    t.index ["availability_id"], name: "index_reservations_on_availability_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
  end

  add_foreign_key "availabilities", "batteries"
  add_foreign_key "reservations", "availabilities"
  add_foreign_key "reservations", "users"
end
