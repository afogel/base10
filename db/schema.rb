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

ActiveRecord::Schema[7.0].define(version: 2023_08_20_133009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "entry_period", ["year", "quarter", "month"]

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.datetime "published_at"
    t.string "announcement_type"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_models", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_models_companies", id: false, force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "business_model_id", null: false
    t.index ["business_model_id", "company_id"], name: "business_model_company_index"
    t.index ["company_id", "business_model_id"], name: "company_business_model_index"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "domain"
    t.string "hq_city"
    t.string "hq_state"
    t.integer "founding_year"
    t.string "hq_zip_code"
    t.string "hq_country"
    t.string "investors"
    t.string "founders"
    t.string "round"
    t.string "raised"
    t.integer "employee_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "companies_segments", id: false, force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "segment_id", null: false
    t.index ["company_id", "segment_id"], name: "index_companies_segments_on_company_id_and_segment_id"
    t.index ["segment_id", "company_id"], name: "index_companies_segments_on_segment_id_and_company_id"
  end

  create_table "company_entries", force: :cascade do |t|
    t.date "entry_date"
    t.enum "entry_period", default: "year", enum_type: "entry_period"
    t.integer "revenue"
    t.integer "cash_burn"
    t.integer "gross_profit"
    t.decimal "gross_profit_pct"
    t.integer "ebitda"
    t.integer "cash_on_hand"
    t.integer "cac"
    t.integer "ltv"
    t.integer "arpu"
    t.integer "customer_count"
    t.date "next_fundraise_at"
    t.bigint "user_id", null: false
    t.bigint "source_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.virtual "revenue_annualized", type: :integer, as: "\nCASE\n    WHEN (entry_period = 'month'::entry_period) THEN (revenue * 12)\n    WHEN (entry_period = 'quarter'::entry_period) THEN (revenue * 4)\n    ELSE revenue\nEND", stored: true
    t.virtual "cash_burn_annualized", type: :integer, as: "\nCASE\n    WHEN (entry_period = 'month'::entry_period) THEN (cash_burn * 12)\n    WHEN (entry_period = 'quarter'::entry_period) THEN (cash_burn * 4)\n    ELSE cash_burn\nEND", stored: true
    t.virtual "gross_profit_annualized", type: :integer, as: "\nCASE\n    WHEN (entry_period = 'month'::entry_period) THEN (gross_profit * 12)\n    WHEN (entry_period = 'quarter'::entry_period) THEN (gross_profit * 4)\n    ELSE gross_profit\nEND", stored: true
    t.virtual "ebitda_annualized", type: :integer, as: "\nCASE\n    WHEN (entry_period = 'month'::entry_period) THEN (ebitda * 12)\n    WHEN (entry_period = 'quarter'::entry_period) THEN (ebitda * 4)\n    ELSE ebitda\nEND", stored: true
    t.index ["company_id"], name: "index_company_entries_on_company_id"
    t.index ["source_id"], name: "index_company_entries_on_source_id"
    t.index ["user_id"], name: "index_company_entries_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "segments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_segments_on_industry_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider"
    t.string "uid"
    t.string "access_token"
    t.string "access_token_secret"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.text "auth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "announcements_last_read_at"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "company_entries", "companies"
  add_foreign_key "company_entries", "sources"
  add_foreign_key "company_entries", "users"
  add_foreign_key "services", "users"
end
