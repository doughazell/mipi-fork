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

ActiveRecord::Schema.define(:version => 20120803135140) do

  create_table "address_data_elements", :force => true do |t|
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "address_line_3"
    t.string "city"
    t.string "post_code"
    t.string "country"
  end

  create_table "birth_data_elements", :force => true do |t|
    t.date   "date_of_birth"
    t.string "town_of_birth"
    t.string "country_of_birth"
  end

  create_table "buildings_insurance_data_elements", :force => true do |t|
    t.float   "insured_value",         :limit => nil
    t.integer "house_data_element_id"
  end

  create_table "contact_data_elements", :force => true do |t|
    t.string "first_name"
    t.string "other_names"
    t.string "last_name"
    t.string "email"
  end

  create_table "contents_insurance_data_elements", :force => true do |t|
    t.float   "insured_value",         :limit => nil
    t.float   "excess",                :limit => nil
    t.integer "house_data_element_id"
  end

  create_table "council_tax_data_elements", :force => true do |t|
    t.string "full_name"
    t.string "account_number"
    t.string "contact_address_line_1"
    t.string "contact_address_line_2"
    t.string "contact_address_line_3"
    t.string "contact_city"
    t.string "contact_county"
    t.string "contact_postcode"
    t.string "property_address_line_1"
    t.string "property_address_line_2"
    t.string "property_address_line_3"
    t.string "property_city"
    t.string "property_county"
    t.string "property_postcode"
    t.string "property_reference"
    t.string "band"
    t.date   "date_of_issue"
  end

  create_table "data_domain_data_elements", :force => true do |t|
    t.string "code"
    t.string "short_name"
    t.string "description"
  end

  create_table "data_element_collections", :force => true do |t|
    t.string   "name"
    t.string   "security"
    t.string   "archive_criteria"
    t.string   "data_element_type"
    t.integer  "page_limit"
    t.boolean  "historic"
    t.string   "variable_name"
    t.string   "order_by_column",   :default => "created_at DESC"
    t.integer  "globe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_element_links", :force => true do |t|
    t.string   "remote_globe_identifier"
    t.integer  "data_element_id"
    t.string   "attribute_name"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_element_meta_datas", :force => true do |t|
    t.string   "data_element_type"
    t.string   "name"
    t.string   "definition"
    t.string   "field_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_html_modifier", :default => "text_field"
  end

  create_table "data_elements", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "data_element_collection_id"
    t.integer  "user_id"
    t.integer  "ready_to_archive"
    t.string   "label"
    t.boolean  "mandatory"
    t.integer  "globe_id"
    t.integer  "version",                    :default => 1
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_line_item_data_elements", :force => true do |t|
    t.string  "code"
    t.string  "short_name"
    t.string  "description"
    t.integer "data_set_data_element_id"
  end

  create_table "data_set_data_elements", :force => true do |t|
    t.string  "code"
    t.string  "short_name"
    t.string  "description"
    t.integer "data_sub_domain_data_element_id"
  end

  create_table "data_sheets", :force => true do |t|
    t.string   "name"
    t.string   "display_name"
    t.string   "class_style"
    t.string   "style_sheets"
    t.integer  "profile_id"
    t.string   "file_location"
    t.integer  "position"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_sub_domain_data_elements", :force => true do |t|
    t.string  "code"
    t.string  "short_name"
    t.string  "description"
    t.integer "data_domain_data_element_id"
  end

  create_table "ecb_cricket_club_data_elements", :force => true do |t|
    t.string "location"
    t.string "county"
    t.string "weburl"
    t.string "contact_name"
    t.string "contact_number"
  end

  create_table "enhanced_transaction_data_elements", :force => true do |t|
    t.integer "party_id"
  end

  create_table "financial_account_data_elements", :force => true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.date    "date_of_birth"
    t.string  "bank_name"
    t.string  "account_name"
    t.string  "account_type"
    t.string  "sort_code"
    t.string  "account_number"
    t.integer "bank_address_id"
    t.date    "open_date"
    t.date    "closed_date"
    t.float   "overdraft_limit", :limit => nil
  end

  create_table "generator_unit_data_elements", :force => true do |t|
    t.string  "code"
    t.float   "installed_capacity",            :limit => nil
    t.float   "fixed_heat_constant",           :limit => nil
    t.float   "start_hours_hot",               :limit => nil
    t.float   "start_hours_cold",              :limit => nil
    t.integer "power_station_data_element_id"
  end

  create_table "globes", :force => true do |t|
    t.string   "name"
    t.string   "globe_reference"
    t.integer  "parent_id"
    t.string   "security"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "house_data_elements", :force => true do |t|
    t.string  "property_type"
    t.string  "ownership_type"
    t.integer "bedrooms"
    t.integer "bathrooms"
    t.integer "reception_rooms"
    t.boolean "garden"
    t.string  "roof_material"
    t.string  "external_construction"
    t.integer "flood_plain"
  end

  create_table "insurance_data_elements", :force => true do |t|
    t.string "policy_reference"
    t.date   "expires"
    t.date   "commences"
  end

  create_table "membership_data_elements", :force => true do |t|
    t.string  "full_name"
    t.string  "email_address"
    t.date    "date_of_birth"
    t.string  "gender"
    t.date    "date_of_registration"
    t.string  "membership_level"
    t.boolean "direct_mail_opt_in"
    t.boolean "direct_email_opt_in"
    t.boolean "third_party_promotion_opt_in"
  end

  create_table "message_data_elements", :force => true do |t|
    t.boolean "hidden"
    t.integer "message_id"
    t.string  "message_text"
  end

  create_table "message_severities", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.string   "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "definition"
    t.integer  "message_severity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "name_data_elements", :force => true do |t|
    t.string "first_name"
    t.string "other_names"
    t.string "last_name"
  end

  create_table "notification_data_elements", :force => true do |t|
    t.string "email"
  end

  create_table "phone_number_data_elements", :force => true do |t|
    t.string "phone_type"
    t.string "phone_number"
  end

  create_table "power_station_data_elements", :force => true do |t|
    t.string  "full_name"
    t.string  "code"
    t.string  "primary_fuel_type"
    t.string  "secondary_fuel_type"
    t.string  "location"
    t.integer "capacity"
    t.date    "commissioned"
  end

  create_table "presentations", :force => true do |t|
    t.integer  "data_sheet_id"
    t.integer  "data_element_collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.integer  "globe_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_data_elements", :force => true do |t|
    t.integer "address_data_element_id"
    t.integer "year_built"
  end

  create_table "registrations", :force => true do |t|
    t.integer  "globe_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rfu_membership_data_elements", :force => true do |t|
    t.string "rfu_team_supported"
  end

  create_table "stated_item_on_insurance_data_elements", :force => true do |t|
    t.string  "description"
    t.float   "value",                              :limit => nil
    t.integer "contents_insurance_data_element_id"
  end

  create_table "string_data_elements", :force => true do |t|
    t.string "value"
  end

  create_table "subscription_evalutaion_queues", :force => true do |t|
    t.integer  "subscription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_message_data_elements", :force => true do |t|
    t.integer "subscription_id"
  end

  create_table "subscription_types", :force => true do |t|
    t.string "name"
    t.string "definition"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "source_link_id"
    t.integer  "destination_link_id"
    t.integer  "subscription_type_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transaction_data_elements", :force => true do |t|
    t.date   "transfer_date"
    t.string "transaction_type"
    t.string "description"
    t.float  "value",            :limit => nil
    t.float  "balance",          :limit => nil
  end

  create_table "transaction_type_references", :force => true do |t|
    t.string   "code"
    t.string   "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transmission_loss_adjustment_data_elements", :force => true do |t|
    t.datetime "month"
    t.integer  "power_station_data_element_id"
    t.float    "adjustment",                    :limit => nil
    t.integer  "daytime_indicator"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicle_data_elements", :force => true do |t|
    t.string "registration"
    t.string "make"
    t.string "model"
    t.string "colour"
  end

  create_table "vehicle_reminder_data_elements", :force => true do |t|
    t.date    "reminder_date"
    t.integer "notification_data_element_id"
    t.integer "reminder_type_data_element_id"
  end

  create_table "vehicle_reminder_type_data_elements", :force => true do |t|
    t.string "description"
  end

  create_table "vehicle_service_data_elements", :force => true do |t|
    t.date    "service_date"
    t.string  "details"
    t.string  "signator"
    t.integer "vehicle_data_element_id"
  end

end
