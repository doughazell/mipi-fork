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
    t.float   "insured_value"
    t.integer "house_data_element_id"
  end

  create_table "contact_data_elements", :force => true do |t|
    t.string "first_name"
    t.string "other_names"
    t.string "last_name"
    t.string "email"
  end

  create_table "contents_insurance_data_elements", :force => true do |t|
    t.float   "insured_value"
    t.float   "excess"
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
    t.string   "inheritance_column_name"
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
    t.float   "overdraft_limit"
  end

  create_table "generator_unit_data_elements", :force => true do |t|
    t.string  "code"
    t.float   "installed_capacity"
    t.float   "fixed_heat_constant"
    t.float   "start_hours_hot"
    t.float   "start_hours_cold"
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
    t.float   "value"
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
    t.float  "value"
    t.float  "balance"
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
    t.float    "adjustment"
    t.integer  "daytime_indicator"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "password_salt",          :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
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

  create_view "view_address_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`address_data_elements`.`address_line_1` AS `address_line_1`,`address_data_elements`.`address_line_2` AS `address_line_2`,`address_data_elements`.`address_line_3` AS `address_line_3`,`address_data_elements`.`city` AS `city`,`address_data_elements`.`post_code` AS `post_code`,`address_data_elements`.`country` AS `country` from (`data_elements` join `address_data_elements`) where (`data_elements`.`id` = `address_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :address_line_1
    v.column :address_line_2
    v.column :address_line_3
    v.column :city
    v.column :post_code
    v.column :country
  end

  create_view "view_birth_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`birth_data_elements`.`date_of_birth` AS `date_of_birth`,`birth_data_elements`.`town_of_birth` AS `town_of_birth`,`birth_data_elements`.`country_of_birth` AS `country_of_birth` from (`data_elements` join `birth_data_elements`) where (`data_elements`.`id` = `birth_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :date_of_birth
    v.column :town_of_birth
    v.column :country_of_birth
  end

  create_view "view_buildings_insurance_data_elements", "select `view_insurance_data_elements`.`id` AS `id`,`view_insurance_data_elements`.`type` AS `type`,`view_insurance_data_elements`.`name` AS `name`,`view_insurance_data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`view_insurance_data_elements`.`user_id` AS `user_id`,`view_insurance_data_elements`.`ready_to_archive` AS `ready_to_archive`,`view_insurance_data_elements`.`label` AS `label`,`view_insurance_data_elements`.`mandatory` AS `mandatory`,`view_insurance_data_elements`.`globe_id` AS `globe_id`,`view_insurance_data_elements`.`version` AS `version`,`view_insurance_data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`view_insurance_data_elements`.`creator_id` AS `creator_id`,`view_insurance_data_elements`.`updater_id` AS `updater_id`,`view_insurance_data_elements`.`created_at` AS `created_at`,`view_insurance_data_elements`.`updated_at` AS `updated_at`,`view_insurance_data_elements`.`policy_reference` AS `policy_reference`,`view_insurance_data_elements`.`expires` AS `expires`,`view_insurance_data_elements`.`commences` AS `commences`,`buildings_insurance_data_elements`.`insured_value` AS `insured_value`,`buildings_insurance_data_elements`.`house_data_element_id` AS `house_data_element_id` from (`view_insurance_data_elements` join `buildings_insurance_data_elements`) where (`view_insurance_data_elements`.`id` = `buildings_insurance_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :policy_reference
    v.column :expires
    v.column :commences
    v.column :insured_value
    v.column :house_data_element_id
  end

  create_view "view_contact_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`contact_data_elements`.`first_name` AS `first_name`,`contact_data_elements`.`other_names` AS `other_names`,`contact_data_elements`.`last_name` AS `last_name`,`contact_data_elements`.`email` AS `email` from (`data_elements` join `contact_data_elements`) where (`data_elements`.`id` = `contact_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :first_name
    v.column :other_names
    v.column :last_name
    v.column :email
  end

  create_view "view_contents_insurance_data_elements", "select `view_insurance_data_elements`.`id` AS `id`,`view_insurance_data_elements`.`type` AS `type`,`view_insurance_data_elements`.`name` AS `name`,`view_insurance_data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`view_insurance_data_elements`.`user_id` AS `user_id`,`view_insurance_data_elements`.`ready_to_archive` AS `ready_to_archive`,`view_insurance_data_elements`.`label` AS `label`,`view_insurance_data_elements`.`mandatory` AS `mandatory`,`view_insurance_data_elements`.`globe_id` AS `globe_id`,`view_insurance_data_elements`.`version` AS `version`,`view_insurance_data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`view_insurance_data_elements`.`creator_id` AS `creator_id`,`view_insurance_data_elements`.`updater_id` AS `updater_id`,`view_insurance_data_elements`.`created_at` AS `created_at`,`view_insurance_data_elements`.`updated_at` AS `updated_at`,`view_insurance_data_elements`.`policy_reference` AS `policy_reference`,`view_insurance_data_elements`.`expires` AS `expires`,`view_insurance_data_elements`.`commences` AS `commences`,`contents_insurance_data_elements`.`insured_value` AS `insured_value`,`contents_insurance_data_elements`.`excess` AS `excess`,`contents_insurance_data_elements`.`house_data_element_id` AS `house_data_element_id` from (`view_insurance_data_elements` join `contents_insurance_data_elements`) where (`view_insurance_data_elements`.`id` = `contents_insurance_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :policy_reference
    v.column :expires
    v.column :commences
    v.column :insured_value
    v.column :excess
    v.column :house_data_element_id
  end

  create_view "view_council_tax_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`council_tax_data_elements`.`full_name` AS `full_name`,`council_tax_data_elements`.`account_number` AS `account_number`,`council_tax_data_elements`.`contact_address_line_1` AS `contact_address_line_1`,`council_tax_data_elements`.`contact_address_line_2` AS `contact_address_line_2`,`council_tax_data_elements`.`contact_address_line_3` AS `contact_address_line_3`,`council_tax_data_elements`.`contact_city` AS `contact_city`,`council_tax_data_elements`.`contact_county` AS `contact_county`,`council_tax_data_elements`.`contact_postcode` AS `contact_postcode`,`council_tax_data_elements`.`property_address_line_1` AS `property_address_line_1`,`council_tax_data_elements`.`property_address_line_2` AS `property_address_line_2`,`council_tax_data_elements`.`property_address_line_3` AS `property_address_line_3`,`council_tax_data_elements`.`property_city` AS `property_city`,`council_tax_data_elements`.`property_county` AS `property_county`,`council_tax_data_elements`.`property_postcode` AS `property_postcode`,`council_tax_data_elements`.`property_reference` AS `property_reference`,`council_tax_data_elements`.`band` AS `band`,`council_tax_data_elements`.`date_of_issue` AS `date_of_issue` from (`data_elements` join `council_tax_data_elements`) where (`data_elements`.`id` = `council_tax_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :full_name
    v.column :account_number
    v.column :contact_address_line_1
    v.column :contact_address_line_2
    v.column :contact_address_line_3
    v.column :contact_city
    v.column :contact_county
    v.column :contact_postcode
    v.column :property_address_line_1
    v.column :property_address_line_2
    v.column :property_address_line_3
    v.column :property_city
    v.column :property_county
    v.column :property_postcode
    v.column :property_reference
    v.column :band
    v.column :date_of_issue
  end

  create_view "view_data_domain_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`data_domain_data_elements`.`code` AS `code`,`data_domain_data_elements`.`short_name` AS `short_name`,`data_domain_data_elements`.`description` AS `description` from (`data_elements` join `data_domain_data_elements`) where (`data_elements`.`id` = `data_domain_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :code
    v.column :short_name
    v.column :description
  end

  create_view "view_data_line_item_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`data_line_item_data_elements`.`code` AS `code`,`data_line_item_data_elements`.`short_name` AS `short_name`,`data_line_item_data_elements`.`description` AS `description`,`data_line_item_data_elements`.`data_set_data_element_id` AS `data_set_data_element_id` from (`data_elements` join `data_line_item_data_elements`) where (`data_elements`.`id` = `data_line_item_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :code
    v.column :short_name
    v.column :description
    v.column :data_set_data_element_id
  end

  create_view "view_data_set_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`data_set_data_elements`.`code` AS `code`,`data_set_data_elements`.`short_name` AS `short_name`,`data_set_data_elements`.`description` AS `description`,`data_set_data_elements`.`data_sub_domain_data_element_id` AS `data_sub_domain_data_element_id` from (`data_elements` join `data_set_data_elements`) where (`data_elements`.`id` = `data_set_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :code
    v.column :short_name
    v.column :description
    v.column :data_sub_domain_data_element_id
  end

  create_view "view_data_sub_domain_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`data_sub_domain_data_elements`.`code` AS `code`,`data_sub_domain_data_elements`.`short_name` AS `short_name`,`data_sub_domain_data_elements`.`description` AS `description`,`data_sub_domain_data_elements`.`data_domain_data_element_id` AS `data_domain_data_element_id` from (`data_elements` join `data_sub_domain_data_elements`) where (`data_elements`.`id` = `data_sub_domain_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :code
    v.column :short_name
    v.column :description
    v.column :data_domain_data_element_id
  end

  create_view "view_ecb_cricket_club_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`ecb_cricket_club_data_elements`.`location` AS `location`,`ecb_cricket_club_data_elements`.`county` AS `county`,`ecb_cricket_club_data_elements`.`weburl` AS `weburl`,`ecb_cricket_club_data_elements`.`contact_name` AS `contact_name`,`ecb_cricket_club_data_elements`.`contact_number` AS `contact_number` from (`data_elements` join `ecb_cricket_club_data_elements`) where (`data_elements`.`id` = `ecb_cricket_club_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :location
    v.column :county
    v.column :weburl
    v.column :contact_name
    v.column :contact_number
  end

  create_view "view_enhanced_transaction_data_elements", "select `view_transaction_data_elements`.`id` AS `id`,`view_transaction_data_elements`.`type` AS `type`,`view_transaction_data_elements`.`name` AS `name`,`view_transaction_data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`view_transaction_data_elements`.`user_id` AS `user_id`,`view_transaction_data_elements`.`ready_to_archive` AS `ready_to_archive`,`view_transaction_data_elements`.`label` AS `label`,`view_transaction_data_elements`.`mandatory` AS `mandatory`,`view_transaction_data_elements`.`globe_id` AS `globe_id`,`view_transaction_data_elements`.`version` AS `version`,`view_transaction_data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`view_transaction_data_elements`.`creator_id` AS `creator_id`,`view_transaction_data_elements`.`updater_id` AS `updater_id`,`view_transaction_data_elements`.`created_at` AS `created_at`,`view_transaction_data_elements`.`updated_at` AS `updated_at`,`view_transaction_data_elements`.`transfer_date` AS `transfer_date`,`view_transaction_data_elements`.`transaction_type` AS `transaction_type`,`view_transaction_data_elements`.`description` AS `description`,`view_transaction_data_elements`.`value` AS `value`,`view_transaction_data_elements`.`balance` AS `balance`,`enhanced_transaction_data_elements`.`party_id` AS `party_id` from (`view_transaction_data_elements` join `enhanced_transaction_data_elements`) where (`view_transaction_data_elements`.`id` = `enhanced_transaction_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :transfer_date
    v.column :transaction_type
    v.column :description
    v.column :value
    v.column :balance
    v.column :party_id
  end

  create_view "view_financial_account_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`financial_account_data_elements`.`first_name` AS `first_name`,`financial_account_data_elements`.`last_name` AS `last_name`,`financial_account_data_elements`.`date_of_birth` AS `date_of_birth`,`financial_account_data_elements`.`bank_name` AS `bank_name`,`financial_account_data_elements`.`account_name` AS `account_name`,`financial_account_data_elements`.`account_type` AS `account_type`,`financial_account_data_elements`.`sort_code` AS `sort_code`,`financial_account_data_elements`.`account_number` AS `account_number`,`financial_account_data_elements`.`bank_address_id` AS `bank_address_id`,`financial_account_data_elements`.`open_date` AS `open_date`,`financial_account_data_elements`.`closed_date` AS `closed_date`,`financial_account_data_elements`.`overdraft_limit` AS `overdraft_limit` from (`data_elements` join `financial_account_data_elements`) where (`data_elements`.`id` = `financial_account_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :first_name
    v.column :last_name
    v.column :date_of_birth
    v.column :bank_name
    v.column :account_name
    v.column :account_type
    v.column :sort_code
    v.column :account_number
    v.column :bank_address_id
    v.column :open_date
    v.column :closed_date
    v.column :overdraft_limit
  end

  create_view "view_generator_unit_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`generator_unit_data_elements`.`code` AS `code`,`generator_unit_data_elements`.`installed_capacity` AS `installed_capacity`,`generator_unit_data_elements`.`fixed_heat_constant` AS `fixed_heat_constant`,`generator_unit_data_elements`.`start_hours_hot` AS `start_hours_hot`,`generator_unit_data_elements`.`start_hours_cold` AS `start_hours_cold`,`generator_unit_data_elements`.`power_station_data_element_id` AS `power_station_data_element_id` from (`data_elements` join `generator_unit_data_elements`) where (`data_elements`.`id` = `generator_unit_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :code
    v.column :installed_capacity
    v.column :fixed_heat_constant
    v.column :start_hours_hot
    v.column :start_hours_cold
    v.column :power_station_data_element_id
  end

  create_view "view_house_data_elements", "select `view_property_data_elements`.`id` AS `id`,`view_property_data_elements`.`type` AS `type`,`view_property_data_elements`.`name` AS `name`,`view_property_data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`view_property_data_elements`.`user_id` AS `user_id`,`view_property_data_elements`.`ready_to_archive` AS `ready_to_archive`,`view_property_data_elements`.`label` AS `label`,`view_property_data_elements`.`mandatory` AS `mandatory`,`view_property_data_elements`.`globe_id` AS `globe_id`,`view_property_data_elements`.`version` AS `version`,`view_property_data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`view_property_data_elements`.`creator_id` AS `creator_id`,`view_property_data_elements`.`updater_id` AS `updater_id`,`view_property_data_elements`.`created_at` AS `created_at`,`view_property_data_elements`.`updated_at` AS `updated_at`,`view_property_data_elements`.`address_data_element_id` AS `address_data_element_id`,`view_property_data_elements`.`year_built` AS `year_built`,`house_data_elements`.`property_type` AS `property_type`,`house_data_elements`.`ownership_type` AS `ownership_type`,`house_data_elements`.`bedrooms` AS `bedrooms`,`house_data_elements`.`bathrooms` AS `bathrooms`,`house_data_elements`.`reception_rooms` AS `reception_rooms`,`house_data_elements`.`garden` AS `garden`,`house_data_elements`.`roof_material` AS `roof_material`,`house_data_elements`.`external_construction` AS `external_construction`,`house_data_elements`.`flood_plain` AS `flood_plain` from (`view_property_data_elements` join `house_data_elements`) where (`view_property_data_elements`.`id` = `house_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :address_data_element_id
    v.column :year_built
    v.column :property_type
    v.column :ownership_type
    v.column :bedrooms
    v.column :bathrooms
    v.column :reception_rooms
    v.column :garden
    v.column :roof_material
    v.column :external_construction
    v.column :flood_plain
  end

  create_view "view_insurance_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`insurance_data_elements`.`policy_reference` AS `policy_reference`,`insurance_data_elements`.`expires` AS `expires`,`insurance_data_elements`.`commences` AS `commences` from (`data_elements` join `insurance_data_elements`) where (`data_elements`.`id` = `insurance_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :policy_reference
    v.column :expires
    v.column :commences
  end

  create_view "view_membership_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`membership_data_elements`.`full_name` AS `full_name`,`membership_data_elements`.`email_address` AS `email_address`,`membership_data_elements`.`date_of_birth` AS `date_of_birth`,`membership_data_elements`.`gender` AS `gender`,`membership_data_elements`.`date_of_registration` AS `date_of_registration`,`membership_data_elements`.`membership_level` AS `membership_level`,`membership_data_elements`.`direct_mail_opt_in` AS `direct_mail_opt_in`,`membership_data_elements`.`direct_email_opt_in` AS `direct_email_opt_in`,`membership_data_elements`.`third_party_promotion_opt_in` AS `third_party_promotion_opt_in` from (`data_elements` join `membership_data_elements`) where (`data_elements`.`id` = `membership_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :full_name
    v.column :email_address
    v.column :date_of_birth
    v.column :gender
    v.column :date_of_registration
    v.column :membership_level
    v.column :direct_mail_opt_in
    v.column :direct_email_opt_in
    v.column :third_party_promotion_opt_in
  end

  create_view "view_message_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`message_data_elements`.`hidden` AS `hidden`,`message_data_elements`.`message_id` AS `message_id`,`message_data_elements`.`message_text` AS `message_text` from (`data_elements` join `message_data_elements`) where (`data_elements`.`id` = `message_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :hidden
    v.column :message_id
    v.column :message_text
  end

  create_view "view_name_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`name_data_elements`.`first_name` AS `first_name`,`name_data_elements`.`other_names` AS `other_names`,`name_data_elements`.`last_name` AS `last_name` from (`data_elements` join `name_data_elements`) where (`data_elements`.`id` = `name_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :first_name
    v.column :other_names
    v.column :last_name
  end

  create_view "view_notification_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`notification_data_elements`.`email` AS `email` from (`data_elements` join `notification_data_elements`) where (`data_elements`.`id` = `notification_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :email
  end

  create_view "view_phone_number_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`phone_number_data_elements`.`phone_type` AS `phone_type`,`phone_number_data_elements`.`phone_number` AS `phone_number` from (`data_elements` join `phone_number_data_elements`) where (`data_elements`.`id` = `phone_number_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :phone_type
    v.column :phone_number
  end

  create_view "view_power_station_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`power_station_data_elements`.`full_name` AS `full_name`,`power_station_data_elements`.`code` AS `code`,`power_station_data_elements`.`primary_fuel_type` AS `primary_fuel_type`,`power_station_data_elements`.`secondary_fuel_type` AS `secondary_fuel_type`,`power_station_data_elements`.`location` AS `location`,`power_station_data_elements`.`capacity` AS `capacity`,`power_station_data_elements`.`commissioned` AS `commissioned` from (`data_elements` join `power_station_data_elements`) where (`data_elements`.`id` = `power_station_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :full_name
    v.column :code
    v.column :primary_fuel_type
    v.column :secondary_fuel_type
    v.column :location
    v.column :capacity
    v.column :commissioned
  end

  create_view "view_property_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`property_data_elements`.`address_data_element_id` AS `address_data_element_id`,`property_data_elements`.`year_built` AS `year_built` from (`data_elements` join `property_data_elements`) where (`data_elements`.`id` = `property_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :address_data_element_id
    v.column :year_built
  end

  create_view "view_rfu_membership_data_elements", "select `view_membership_data_elements`.`id` AS `id`,`view_membership_data_elements`.`type` AS `type`,`view_membership_data_elements`.`name` AS `name`,`view_membership_data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`view_membership_data_elements`.`user_id` AS `user_id`,`view_membership_data_elements`.`ready_to_archive` AS `ready_to_archive`,`view_membership_data_elements`.`label` AS `label`,`view_membership_data_elements`.`mandatory` AS `mandatory`,`view_membership_data_elements`.`globe_id` AS `globe_id`,`view_membership_data_elements`.`version` AS `version`,`view_membership_data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`view_membership_data_elements`.`creator_id` AS `creator_id`,`view_membership_data_elements`.`updater_id` AS `updater_id`,`view_membership_data_elements`.`created_at` AS `created_at`,`view_membership_data_elements`.`updated_at` AS `updated_at`,`view_membership_data_elements`.`full_name` AS `full_name`,`view_membership_data_elements`.`email_address` AS `email_address`,`view_membership_data_elements`.`date_of_birth` AS `date_of_birth`,`view_membership_data_elements`.`gender` AS `gender`,`view_membership_data_elements`.`date_of_registration` AS `date_of_registration`,`view_membership_data_elements`.`membership_level` AS `membership_level`,`view_membership_data_elements`.`direct_mail_opt_in` AS `direct_mail_opt_in`,`view_membership_data_elements`.`direct_email_opt_in` AS `direct_email_opt_in`,`view_membership_data_elements`.`third_party_promotion_opt_in` AS `third_party_promotion_opt_in`,`rfu_membership_data_elements`.`rfu_team_supported` AS `rfu_team_supported` from (`view_membership_data_elements` join `rfu_membership_data_elements`) where (`view_membership_data_elements`.`id` = `rfu_membership_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :full_name
    v.column :email_address
    v.column :date_of_birth
    v.column :gender
    v.column :date_of_registration
    v.column :membership_level
    v.column :direct_mail_opt_in
    v.column :direct_email_opt_in
    v.column :third_party_promotion_opt_in
    v.column :rfu_team_supported
  end

  create_view "view_stated_item_on_insurance_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`stated_item_on_insurance_data_elements`.`description` AS `description`,`stated_item_on_insurance_data_elements`.`value` AS `value`,`stated_item_on_insurance_data_elements`.`contents_insurance_data_element_id` AS `contents_insurance_data_element_id` from (`data_elements` join `stated_item_on_insurance_data_elements`) where (`data_elements`.`id` = `stated_item_on_insurance_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :description
    v.column :value
    v.column :contents_insurance_data_element_id
  end

  create_view "view_string_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`string_data_elements`.`value` AS `value` from (`data_elements` join `string_data_elements`) where (`data_elements`.`id` = `string_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :value
  end

  create_view "view_subscription_message_data_elements", "select `view_message_data_elements`.`id` AS `id`,`view_message_data_elements`.`type` AS `type`,`view_message_data_elements`.`name` AS `name`,`view_message_data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`view_message_data_elements`.`user_id` AS `user_id`,`view_message_data_elements`.`ready_to_archive` AS `ready_to_archive`,`view_message_data_elements`.`label` AS `label`,`view_message_data_elements`.`mandatory` AS `mandatory`,`view_message_data_elements`.`globe_id` AS `globe_id`,`view_message_data_elements`.`version` AS `version`,`view_message_data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`view_message_data_elements`.`creator_id` AS `creator_id`,`view_message_data_elements`.`updater_id` AS `updater_id`,`view_message_data_elements`.`created_at` AS `created_at`,`view_message_data_elements`.`updated_at` AS `updated_at`,`view_message_data_elements`.`hidden` AS `hidden`,`view_message_data_elements`.`message_id` AS `message_id`,`view_message_data_elements`.`message_text` AS `message_text`,`subscription_message_data_elements`.`subscription_id` AS `subscription_id` from (`view_message_data_elements` join `subscription_message_data_elements`) where (`view_message_data_elements`.`id` = `subscription_message_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :hidden
    v.column :message_id
    v.column :message_text
    v.column :subscription_id
  end

  create_view "view_transaction_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`transaction_data_elements`.`transfer_date` AS `transfer_date`,`transaction_data_elements`.`transaction_type` AS `transaction_type`,`transaction_data_elements`.`description` AS `description`,`transaction_data_elements`.`value` AS `value`,`transaction_data_elements`.`balance` AS `balance` from (`data_elements` join `transaction_data_elements`) where (`data_elements`.`id` = `transaction_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :transfer_date
    v.column :transaction_type
    v.column :description
    v.column :value
    v.column :balance
  end

  create_view "view_transmission_loss_adjustment_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`transmission_loss_adjustment_data_elements`.`month` AS `month`,`transmission_loss_adjustment_data_elements`.`power_station_data_element_id` AS `power_station_data_element_id`,`transmission_loss_adjustment_data_elements`.`adjustment` AS `adjustment`,`transmission_loss_adjustment_data_elements`.`daytime_indicator` AS `daytime_indicator` from (`data_elements` join `transmission_loss_adjustment_data_elements`) where (`data_elements`.`id` = `transmission_loss_adjustment_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :month
    v.column :power_station_data_element_id
    v.column :adjustment
    v.column :daytime_indicator
  end

  create_view "view_vehicle_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`vehicle_data_elements`.`registration` AS `registration`,`vehicle_data_elements`.`make` AS `make`,`vehicle_data_elements`.`model` AS `model`,`vehicle_data_elements`.`colour` AS `colour` from (`data_elements` join `vehicle_data_elements`) where (`data_elements`.`id` = `vehicle_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :registration
    v.column :make
    v.column :model
    v.column :colour
  end

  create_view "view_vehicle_reminder_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`vehicle_reminder_data_elements`.`reminder_date` AS `reminder_date`,`vehicle_reminder_data_elements`.`notification_data_element_id` AS `notification_data_element_id`,`vehicle_reminder_data_elements`.`reminder_type_data_element_id` AS `reminder_type_data_element_id` from (`data_elements` join `vehicle_reminder_data_elements`) where (`data_elements`.`id` = `vehicle_reminder_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :reminder_date
    v.column :notification_data_element_id
    v.column :reminder_type_data_element_id
  end

  create_view "view_vehicle_reminder_type_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`vehicle_reminder_type_data_elements`.`description` AS `description` from (`data_elements` join `vehicle_reminder_type_data_elements`) where (`data_elements`.`id` = `vehicle_reminder_type_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :description
  end

  create_view "view_vehicle_service_data_elements", "select `data_elements`.`id` AS `id`,`data_elements`.`type` AS `type`,`data_elements`.`name` AS `name`,`data_elements`.`data_element_collection_id` AS `data_element_collection_id`,`data_elements`.`user_id` AS `user_id`,`data_elements`.`ready_to_archive` AS `ready_to_archive`,`data_elements`.`label` AS `label`,`data_elements`.`mandatory` AS `mandatory`,`data_elements`.`globe_id` AS `globe_id`,`data_elements`.`version` AS `version`,`data_elements`.`inheritance_column_name` AS `inheritance_column_name`,`data_elements`.`creator_id` AS `creator_id`,`data_elements`.`updater_id` AS `updater_id`,`data_elements`.`created_at` AS `created_at`,`data_elements`.`updated_at` AS `updated_at`,`vehicle_service_data_elements`.`service_date` AS `service_date`,`vehicle_service_data_elements`.`details` AS `details`,`vehicle_service_data_elements`.`signator` AS `signator`,`vehicle_service_data_elements`.`vehicle_data_element_id` AS `vehicle_data_element_id` from (`data_elements` join `vehicle_service_data_elements`) where (`data_elements`.`id` = `vehicle_service_data_elements`.`id`)", :force => true do |v|
    v.column :id
    v.column :type
    v.column :name
    v.column :data_element_collection_id
    v.column :user_id
    v.column :ready_to_archive
    v.column :label
    v.column :mandatory
    v.column :globe_id
    v.column :version
    v.column :inheritance_column_name
    v.column :creator_id
    v.column :updater_id
    v.column :created_at
    v.column :updated_at
    v.column :service_date
    v.column :details
    v.column :signator
    v.column :vehicle_data_element_id
  end

end
