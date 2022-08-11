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

ActiveRecord::Schema.define(version: 2022_08_11_125923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "incident_severities", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "incident_subjects", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "incident_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.float "lat"
    t.float "long"
    t.datetime "incident_datetime"
    t.integer "incident_year"
    t.text "incident_text"
    t.integer "incident_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "incident_severity_id"
    t.integer "incident_subject_id"
    t.text "narrative"
    t.index ["incident_severity_id"], name: "index_reports_on_incident_severity_id"
    t.index ["incident_subject_id"], name: "index_reports_on_incident_subject_id"
    t.index ["incident_type_id"], name: "index_reports_on_incident_type_id"
    t.index ["incident_year"], name: "index_reports_on_incident_year"
  end

  add_foreign_key "reports", "incident_severities"
  add_foreign_key "reports", "incident_subjects"
  add_foreign_key "reports", "incident_types"
end
