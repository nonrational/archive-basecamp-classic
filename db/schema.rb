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

ActiveRecord::Schema[7.0].define(version: 2023_03_28_085159) do
  create_table "attachments", force: :cascade do |t|
    t.integer "batch_id"
    t.integer "byte_size"
    t.integer "category_id"
    t.integer "collection"
    t.datetime "created_on", precision: nil
    t.boolean "current"
    t.string "description"
    t.string "download_url"
    t.string "key"
    t.string "name"
    t.string "original_filename"
    t.integer "owner_id"
    t.string "owner_type"
    t.integer "person_id"
    t.boolean "private"
    t.integer "project_id"
    t.integer "thumbnail_key"
    t.integer "version"
    t.string "project_slug"
  end

  create_table "people", force: :cascade do |t|
    t.integer "client_id"
    t.boolean "deleted"
    t.string "im_handle"
    t.string "im_service"
    t.string "phone_number_fax"
    t.string "phone_number_home"
    t.string "phone_number_mobile"
    t.string "phone_number_office"
    t.string "phone_number_office_ext"
    t.string "title"
    t.string "uuid"
    t.string "first_name"
    t.string "last_name"
    t.string "user_name"
    t.string "time_zone_name"
    t.integer "signal_identity_id"
    t.string "email_address"
    t.string "avatar_url"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

end
