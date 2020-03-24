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

ActiveRecord::Schema.define(version: 2020_03_23_021556) do

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

  create_table "item_sets", force: :cascade do |t|
    t.bigint "user_id"
    t.string "item_set_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "item_no"
    t.integer "item_no_category", comment: "指定なし,Buyma,Amazon.."
    t.string "shop_url"
    t.index ["user_id"], name: "index_item_sets_on_user_id"
  end

  create_table "item_unit_taobao_urls", force: :cascade do |t|
    t.bigint "item_unit_id"
    t.bigint "taobao_url_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_unit_id"], name: "index_item_unit_taobao_urls_on_item_unit_id"
    t.index ["taobao_url_id"], name: "index_item_unit_taobao_urls_on_taobao_url_id"
  end

  create_table "item_units", force: :cascade do |t|
    t.string "item_unit_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_set_id"
    t.bigint "first_candidate_id"
    t.index ["first_candidate_id"], name: "index_item_units_on_first_candidate_id"
    t.index ["item_set_id"], name: "index_item_units_on_item_set_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.integer "price"
    t.integer "trade_no"
    t.string "customer_name"
    t.string "postal"
    t.string "address"
    t.string "phone"
    t.string "color_size"
    t.string "customer_remark"
    t.string "japanese_retailer_remark"
    t.integer "japanese_retailer_status"
    t.bigint "japanese_retailer_id"
    t.bigint "chinese_buyer_id"
    t.integer "estimate_charge"
    t.integer "chinese_buyer_status"
    t.string "chinese_buyer_remark"
    t.integer "actual_charge"
    t.integer "commission_fee"
    t.integer "domestic_shipping_fee"
    t.integer "international_shipping_fee"
    t.integer "other_fee"
    t.integer "tracking_number"
    t.bigint "item_set_id"
    t.index ["chinese_buyer_id"], name: "index_orders_on_chinese_buyer_id"
    t.index ["item_set_id"], name: "index_orders_on_item_set_id"
    t.index ["japanese_retailer_id"], name: "index_orders_on_japanese_retailer_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["order_id"], name: "index_pictures_on_order_id"
  end

  create_table "taobao_color_sizes", force: :cascade do |t|
    t.string "name"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_taobao_color_sizes_on_order_id"
  end

  create_table "taobao_urls", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "is_have_stock", default: 0, null: false
    t.index ["user_id"], name: "index_taobao_urls_on_user_id"
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
  add_foreign_key "item_sets", "users"
  add_foreign_key "item_unit_taobao_urls", "item_units"
  add_foreign_key "item_unit_taobao_urls", "taobao_urls"
  add_foreign_key "item_units", "item_sets"
  add_foreign_key "item_units", "taobao_urls", column: "first_candidate_id"
  add_foreign_key "orders", "item_sets"
  add_foreign_key "orders", "users", column: "chinese_buyer_id"
  add_foreign_key "orders", "users", column: "japanese_retailer_id"
  add_foreign_key "pictures", "orders"
  add_foreign_key "taobao_color_sizes", "orders"
  add_foreign_key "taobao_urls", "users"
  add_foreign_key "user_orders", "orders"
  add_foreign_key "user_orders", "users"
end
