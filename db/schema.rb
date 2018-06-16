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

ActiveRecord::Schema.define(version: 20180616194438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoices", force: :cascade do |t|
    t.bigint "participant_id"
    t.string "total"
    t.boolean "paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_invoices_on_participant_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "party_id"
    t.string "amount"
    t.string "price"
    t.string "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["party_id"], name: "index_items_on_party_id"
  end

  create_table "participant_items", force: :cascade do |t|
    t.bigint "participant_id"
    t.bigint "item_id"
    t.integer "invoice_id"
    t.string "amount"
    t.string "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_participant_items_on_invoice_id"
    t.index ["item_id"], name: "index_participant_items_on_item_id"
    t.index ["participant_id"], name: "index_participant_items_on_participant_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "party_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["party_id"], name: "index_participants_on_party_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "parties", force: :cascade do |t|
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chat_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "telegram_id"
  end

  add_foreign_key "invoices", "participants"
  add_foreign_key "items", "parties"
  add_foreign_key "participant_items", "items"
  add_foreign_key "participant_items", "participants"
  add_foreign_key "participants", "parties"
  add_foreign_key "participants", "users"
end
