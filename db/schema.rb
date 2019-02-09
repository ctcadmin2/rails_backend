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

ActiveRecord::Schema.define(version: 2019_02_09_224859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "registration"
    t.string "cif"
    t.text "address"
    t.string "acc_eur"
    t.string "acc_ron"
    t.string "bank"
    t.string "capital"
    t.string "phone"
    t.string "email"
    t.string "contact"
    t.string "country"
    t.boolean "vies", default: false
    t.boolean "status", default: true
  end

  create_table "credit_notes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "number"
    t.string "start"
    t.string "end"
    t.decimal "value"
    t.string "currency"
    t.text "notes"
    t.boolean "paid"
    t.bigint "vehicle_id"
    t.index ["vehicle_id"], name: "index_credit_notes_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "ssn"
    t.string "lang"
    t.boolean "active", default: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vin"
    t.string "registration"
    t.string "category"
    t.boolean "active"
  end

  add_foreign_key "credit_notes", "vehicles"
end
