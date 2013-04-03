# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130403012813) do

  create_table "actions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "action_code"
  end

  create_table "addresses", :force => true do |t|
    t.string   "street_address"
    t.string   "zipcode"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "demographics", :force => true do |t|
    t.integer  "school_id"
    t.integer  "year_from"
    t.integer  "year_to"
    t.string   "category"
    t.float    "percent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "school_id"
    t.integer  "year_from"
    t.integer  "year_to"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "enrollments", ["year_to"], :name => "index_enrollments_on_year_to"

  create_table "essentials", :force => true do |t|
    t.integer  "school_id"
    t.string   "category"
    t.string   "rating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year_from"
    t.integer  "year_to"
  end

  create_table "isat_scores", :force => true do |t|
    t.integer  "school_id"
    t.integer  "year_from"
    t.integer  "year_to"
    t.string   "subject"
    t.float    "percent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mobilities", :force => true do |t|
    t.integer  "school_id"
    t.integer  "year_from"
    t.integer  "year_to"
    t.float    "rate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "performance_metrics", :force => true do |t|
    t.integer  "school_id"
    t.float    "policy_points"
    t.float    "isat_composite"
    t.float    "value_added_math"
    t.float    "value_added_reading"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "probations", :force => true do |t|
    t.integer  "school_id"
    t.integer  "year_from"
    t.integer  "year_to"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "races", :force => true do |t|
    t.integer  "school_id"
    t.string   "ethnicity"
    t.float    "percent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "school_actions", :force => true do |t|
    t.integer  "school_id"
    t.integer  "action_id"
    t.integer  "result_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "school_addresses", :force => true do |t|
    t.integer  "school_id"
    t.integer  "address_id"
    t.integer  "year_from"
    t.integer  "year_to"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "school_addresses", ["year_from"], :name => "index_school_addresses_on_year_from"
  add_index "school_addresses", ["year_to"], :name => "index_school_addresses_on_year_to"

  create_table "school_distances", :force => true do |t|
    t.integer  "from_school_id"
    t.string   "to_school_id"
    t.float    "distance"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "schools", :force => true do |t|
    t.integer  "cps_id"
    t.string   "short_name"
    t.string   "full_name"
    t.string   "community_area"
    t.string   "school_type"
    t.string   "access_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "phone"
    t.string   "level"
    t.string   "isat_url"
    t.integer  "closing_status"
    t.integer  "receiving_status"
  end

  create_table "utilizations", :force => true do |t|
    t.integer  "school_id"
    t.float    "homerooms"
    t.float    "other_rooms"
    t.integer  "year_from"
    t.integer  "year_to"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "ideal_capacity"
  end

  add_index "utilizations", ["year_to"], :name => "index_utilizations_on_year_to"

end
