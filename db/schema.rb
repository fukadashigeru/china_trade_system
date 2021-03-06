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

ActiveRecord::Schema.define(version: 2020_05_19_002707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actual_item_unit_taobao_urls", force: :cascade do |t|
    t.bigint "actual_item_unit_id"
    t.bigint "taobao_url_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actual_item_unit_id"], name: "index_actual_item_unit_taobao_urls_on_actual_item_unit_id"
    t.index ["taobao_url_id"], name: "index_actual_item_unit_taobao_urls_on_taobao_url_id"
  end

  create_table "actual_item_units", force: :cascade do |t|
    t.bigint "item_unit_id"
    t.bigint "order_id"
    t.bigint "first_candidate_id"
    t.string "item_unit_name"
    t.integer "price"
    t.string "color_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_candidate_id"], name: "index_actual_item_units_on_first_candidate_id"
    t.index ["item_unit_id"], name: "index_actual_item_units_on_item_unit_id"
    t.index ["order_id"], name: "index_actual_item_units_on_order_id"
  end

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

  create_table "color_size_price_images", force: :cascade do |t|
    t.bigint "item_set_id"
    t.string "image"
    t.string "color_size"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_set_id"], name: "index_color_size_price_images_on_item_set_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_user_id", null: false
    t.integer "account_type"
    t.index ["owner_user_id"], name: "index_companies_on_owner_user_id"
  end

  create_table "company_connects", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "connect_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_connects_on_company_id"
    t.index ["connect_id"], name: "index_company_connects_on_connect_id"
  end

  create_table "company_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "company_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "invited_accepted", default: false, null: false
    t.index ["company_id"], name: "index_company_users_on_company_id"
    t.index ["user_id", "company_id"], name: "company_user_unique_index", unique: true
    t.index ["user_id"], name: "index_company_users_on_user_id"
  end

  create_table "connects", force: :cascade do |t|
    t.bigint "from_company_id"
    t.bigint "to_company_id"
    t.integer "contact_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_company_id"], name: "index_connects_on_from_company_id"
    t.index ["to_company_id"], name: "index_connects_on_to_company_id"
  end

  create_table "item_sets", force: :cascade do |t|
    t.string "item_set_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "item_no"
    t.integer "item_no_category", comment: "指定なし,Buyma,Amazon.."
    t.string "shop_url"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_item_sets_on_company_id"
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

  create_table "messages", force: :cascade do |t|
    t.bigint "topic_id"
    t.bigint "company_user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_user_id"], name: "index_messages_on_company_user_id"
    t.index ["topic_id"], name: "index_messages_on_topic_id"
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
    t.bigint "japanese_retailer_id"
    t.bigint "chinese_buyer_id"
    t.index ["chinese_buyer_id"], name: "index_orders_on_chinese_buyer_id"
    t.index ["item_set_id"], name: "index_orders_on_item_set_id"
    t.index ["japanese_retailer_id"], name: "index_orders_on_japanese_retailer_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.bigint "color_size_price_image_id"
    t.index ["color_size_price_image_id"], name: "index_pictures_on_color_size_price_image_id"
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
    t.integer "is_have_stock", default: 1, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_taobao_urls_on_company_id"
  end

  create_table "topics", force: :cascade do |t|
    t.bigint "order_id"
    t.boolean "resolve", default: false, null: false
    t.integer "topic_variety", null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "connect_id"
    t.index ["connect_id"], name: "index_topics_on_connect_id"
    t.index ["order_id"], name: "index_topics_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "actual_item_unit_taobao_urls", "actual_item_units"
  add_foreign_key "actual_item_unit_taobao_urls", "taobao_urls"
  add_foreign_key "actual_item_units", "item_units"
  add_foreign_key "actual_item_units", "orders"
  add_foreign_key "actual_item_units", "taobao_urls", column: "first_candidate_id"
  add_foreign_key "actual_item_varieties", "orders"
  add_foreign_key "actual_taobao_urls", "actual_item_varieties"
  add_foreign_key "color_size_price_images", "item_sets"
  add_foreign_key "companies", "users", column: "owner_user_id"
  add_foreign_key "company_connects", "companies"
  add_foreign_key "company_connects", "connects"
  add_foreign_key "company_users", "companies"
  add_foreign_key "company_users", "users"
  add_foreign_key "connects", "companies", column: "from_company_id"
  add_foreign_key "connects", "companies", column: "to_company_id"
  add_foreign_key "item_sets", "companies"
  add_foreign_key "item_unit_taobao_urls", "item_units"
  add_foreign_key "item_unit_taobao_urls", "taobao_urls"
  add_foreign_key "item_units", "item_sets"
  add_foreign_key "item_units", "taobao_urls", column: "first_candidate_id"
  add_foreign_key "messages", "company_users"
  add_foreign_key "messages", "topics"
  add_foreign_key "orders", "companies", column: "chinese_buyer_id"
  add_foreign_key "orders", "companies", column: "japanese_retailer_id"
  add_foreign_key "orders", "item_sets"
  add_foreign_key "pictures", "color_size_price_images"
  add_foreign_key "pictures", "orders"
  add_foreign_key "taobao_color_sizes", "orders"
  add_foreign_key "taobao_urls", "companies"
  add_foreign_key "topics", "connects"
  add_foreign_key "topics", "orders"
end
