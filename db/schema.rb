# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_25_174615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "deals", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "restaurant_id", null: false
    t.index ["restaurant_id"], name: "index_deals_on_restaurant_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.text "title"
    t.string "description"
    t.string "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "restaurant_id"
    t.index ["restaurant_id"], name: "index_dishes_on_restaurant_id"
  end

  create_table "restaurant_requests", force: :cascade do |t|
    t.text "title"
    t.string "description"
    t.string "price"
    t.string "image_link"
    t.string "location"
    t.string "operating_hours"
    t.integer "no_of_stalls"
    t.string "closed_on"
    t.string "contact"
    t.boolean "halal_certified"
    t.integer "state"
    t.decimal "lng", precision: 10, scale: 6
    t.decimal "lat", precision: 10, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["lat", "lng"], name: "index_restaurant_requests_on_lat_and_lng"
    t.index ["user_id"], name: "index_restaurant_requests_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.text "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "price"
    t.string "image_link"
    t.string "location"
    t.string "operating_hours"
    t.integer "no_of_stalls"
    t.string "closed_on"
    t.string "contact"
    t.boolean "halal_certified"
    t.integer "state"
    t.decimal "lng", precision: 10, scale: 6
    t.decimal "lat", precision: 10, scale: 6
    t.index ["lat", "lng"], name: "index_restaurants_on_lat_and_lng"
  end

  create_table "restaurants_tags", id: false, force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "tag_id"
    t.index ["restaurant_id"], name: "index_restaurants_tags_on_restaurant_id"
    t.index ["tag_id"], name: "index_restaurants_tags_on_tag_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "restaurant_id", null: false
    t.string "title"
    t.string "content"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.bigint "restaurant_id"
    t.index ["restaurant_id"], name: "index_users_on_restaurant_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "deals", "restaurants"
  add_foreign_key "restaurant_requests", "users"
  add_foreign_key "reviews", "restaurants"
  add_foreign_key "reviews", "users"
end
