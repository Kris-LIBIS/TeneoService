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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "code_tables", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.string "inst_code"
    t.string "ext_id", null: false
    t.jsonb "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "ext_id"], name: "index_code_tables_on_type_and_ext_id", unique: true
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "inst_code"
    t.string "ingest_dir"
    t.jsonb "upload_areas", default: "{}", null: false
    t.uuid "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_groups_on_parent_id"
    t.index ["upload_areas"], name: "index_groups_on_upload_areas", using: :gin
  end

  create_table "ingest_agreements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "project_name"
    t.string "collection_name"
    t.string "contact_ingest", array: true
    t.string "contact_collection", array: true
    t.string "contact_system", array: true
    t.string "collection_description"
    t.string "ingest_job_name"
    t.string "collector"
    t.uuid "group_id"
    t.uuid "ingest_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_ingest_agreements_on_group_id"
    t.index ["ingest_model_id"], name: "index_ingest_agreements_on_ingest_model_id"
  end

  create_table "ingest_models", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "entity_type"
    t.string "user_a"
    t.string "user_b"
    t.string "user_c"
    t.string "identifier"
    t.string "status"
    t.jsonb "manifestations", array: true
    t.bigint "access_right_id", null: false
    t.bigint "retention_policy_id", null: false
    t.uuid "template_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["access_right_id"], name: "index_ingest_models_on_access_right_id"
    t.index ["manifestations"], name: "index_ingest_models_on_manifestations", using: :gin
    t.index ["retention_policy_id"], name: "index_ingest_models_on_retention_policy_id"
    t.index ["template_id"], name: "index_ingest_models_on_template_id"
  end

  create_table "ingests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "stage"
    t.string "status"
    t.string "name"
    t.string "base_dir"
    t.uuid "ingest_agreement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingest_agreement_id"], name: "index_ingests_on_ingest_agreement_id"
  end

  create_table "items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "label"
    t.uuid "ingest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingest_id"], name: "index_items_on_ingest_id"
  end

  create_table "memberships", primary_key: ["user_id", "group_id", "role_id"], force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "group_id", null: false
    t.string "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["role_id"], name: "index_memberships_on_role_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "representation_types", primary_key: "name", id: :string, force: :cascade do |t|
    t.string "preservation_type"
    t.string "usage_type"
    t.string "representation_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["preservation_type"], name: "index_representation_types_on_preservation_type"
  end

  create_table "roles", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
  end

  create_table "status_logs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "task"
    t.string "status"
    t.integer "progess"
    t.integer "max"
    t.uuid "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_status_logs_on_item_id"
  end

  create_table "type_db", force: :cascade do |t|
    t.string "group"
    t.string "name"
    t.string "description"
    t.string "mime_types", array: true
    t.string "puids", array: true
    t.string "extensions", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["extensions"], name: "index_type_db_on_extensions", using: :gin
    t.index ["mime_types"], name: "index_type_db_on_mime_types", using: :gin
    t.index ["puids"], name: "index_type_db_on_puids", using: :gin
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.datetime "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ingest_agreements", "groups"
  add_foreign_key "ingest_agreements", "ingest_models"
  add_foreign_key "ingest_models", "code_tables", column: "access_right_id"
  add_foreign_key "ingest_models", "code_tables", column: "retention_policy_id"
  add_foreign_key "ingest_models", "ingest_models", column: "template_id"
  add_foreign_key "ingests", "ingest_agreements"
  add_foreign_key "items", "ingests"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "roles", primary_key: "code"
  add_foreign_key "memberships", "users"
  add_foreign_key "status_logs", "items"
end
