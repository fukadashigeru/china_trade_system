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

ActiveRecord::Schema.define(version: 2019_09_08_044548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actual_item_varieties", force: :cascade do |t|
    t.bigint "order_id"
    t.string "item_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_actual_item_varieties_on_order_id"
  end

  create_table "actual_taobao_urls", force: :cascade do |t|
    t.bigint "actual_item_variety_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actual_item_variety_id"], name: "index_actual_taobao_urls_on_actual_item_variety_id"
  end

  create_table "item_nos", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "item_no"
    t.string "item_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_item_nos_on_user_id"
  end

  create_table "item_varieties", force: :cascade do |t|
    t.bigint "item_no_id"
    t.string "item_taobao_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_no_id"], name: "index_item_varieties_on_item_no_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.integer "price"
    t.integer "trade_no"
    t.string "customer_name"
    t.string "postal"
    t.text "address"
    t.string "phone"
    t.string "color_size"
    t.string "customer_remark"
    t.string "item_name"
    t.string "retailer_remark"
    t.integer "processing_status"
    t.string "taobao_color_size"
    t.integer "retailer_id"
    t.integer "china_buyer_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.bigint "actual_item_variety_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actual_item_variety_id"], name: "index_pictures_on_actual_item_variety_id"
  end

  create_table "taobao_urls", force: :cascade do |t|
    t.bigint "item_variety_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_variety_id"], name: "index_taobao_urls_on_item_variety_id"
  end

  create_table "user_orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_user_orders_on_order_id"
    t.index ["user_id"], name: "index_user_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "account_type", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "actual_item_varieties", "orders"
  add_foreign_key "actual_taobao_urls", "actual_item_varieties"
  add_foreign_key "item_nos", "users"
  add_foreign_key "item_varieties", "item_nos"
  add_foreign_key "pictures", "actual_item_varieties"
  add_foreign_key "taobao_urls", "item_varieties"
  add_foreign_key "user_orders", "orders"
  add_foreign_key "user_orders", "users"
end
