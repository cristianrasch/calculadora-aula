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

ActiveRecord::Schema.define(:version => 20100706140938) do

  create_table "budgets", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "budgets", ["name"], :name => "index_budgets_on_name", :unique => true

  create_table "furnishings", :force => true do |t|
    t.integer  "target"
    t.decimal  "chairs_unit_price"
    t.string   "chairs_unit_price_desc"
    t.integer  "chairs_per_workstation"
    t.decimal  "tables_unit_price"
    t.string   "tables_unit_price_desc"
    t.integer  "tables_per_workstation"
    t.decimal  "others_unit_price"
    t.string   "others_unit_price_desc"
    t.integer  "others_per_workstation"
    t.integer  "budget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "furnishings", ["budget_id"], :name => "index_furnishings_on_budget_id"

  create_table "general_settings", :force => true do |t|
    t.integer  "students_count"
    t.integer  "students_per_workstation"
    t.integer  "teachers_count"
    t.integer  "clients_per_server"
    t.integer  "budget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "general_settings", ["budget_id"], :name => "index_general_settings_on_budget_id", :unique => true

  create_table "hardware_prices", :force => true do |t|
    t.decimal  "ram_unit_price"
    t.string   "ram_unit_price_desc"
    t.decimal  "hd_unit_price"
    t.string   "hd_unit_price_desc"
    t.decimal  "network_cable_unit_price"
    t.string   "network_cable_unit_price_desc"
    t.decimal  "switch_port_unit_price"
    t.string   "switch_port_unit_price_desc"
    t.decimal  "printer_unit_price"
    t.string   "printer_unit_price_desc"
    t.decimal  "scanner_unit_price"
    t.string   "scanner_unit_price_desc"
    t.decimal  "rj45_connector_unit_price"
    t.string   "rj45_connector_unit_price_desc"
    t.decimal  "ups_unit_price"
    t.string   "ups_unit_price_desc"
    t.integer  "budget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ram_unit_price_curr",            :default => 1
    t.integer  "hd_unit_price_curr",             :default => 1
    t.integer  "network_cable_unit_price_curr",  :default => 1
    t.integer  "switch_port_unit_price_curr",    :default => 1
    t.integer  "printer_unit_price_curr",        :default => 1
    t.integer  "scanner_unit_price_curr",        :default => 1
    t.integer  "rj45_connector_unit_price_curr", :default => 1
    t.integer  "ups_unit_price_curr",            :default => 1
  end

  add_index "hardware_prices", ["budget_id"], :name => "index_hardware_prices_on_budget_id", :unique => true

  create_table "lan_settings", :force => true do |t|
    t.integer  "ports_per_switch"
    t.string   "ports_per_switch_desc"
    t.float    "medium_distance_bt_pcs_switch"
    t.string   "medium_distance_bt_pcs_switch_desc"
    t.decimal  "installation_materials_and_wiring_cost",      :precision => 8, :scale => 2
    t.string   "installation_materials_and_wiring_cost_desc"
    t.integer  "budget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "installation_materials_and_wiring_cost_curr",                               :default => 1
  end

  add_index "lan_settings", ["budget_id"], :name => "index_lan_settings_on_budget_id", :unique => true

  create_table "settings", :force => true do |t|
    t.boolean  "students_standalone_workstations_enabled"
    t.boolean  "teachers_standalone_workstations_enabled"
    t.boolean  "thin_clients_enabled"
    t.boolean  "thin_clients_server_enabled"
    t.boolean  "lan_enabled"
    t.boolean  "ups_enabled"
    t.integer  "printers_count"
    t.integer  "scanners_count"
    t.boolean  "students_furnishings_enabled"
    t.boolean  "teachers_furnishings_enabled"
    t.boolean  "servers_furnishings_enabled"
    t.decimal  "building_improvements_cost",               :precision => 8, :scale => 2
    t.string   "building_improvements_cost_desc"
    t.decimal  "electric_installation_cost",               :precision => 8, :scale => 2
    t.string   "electric_installation_cost_desc"
    t.integer  "budget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["budget_id"], :name => "index_settings_on_budget_id", :unique => true

  create_table "software", :force => true do |t|
    t.integer  "target"
    t.integer  "mask"
    t.decimal  "os_unit_price"
    t.string   "os_unit_price_desc"
    t.decimal  "office_suite_unit_price"
    t.string   "office_suite_unit_price_desc"
    t.decimal  "class_mon_n_ctrl_apps_unit_price"
    t.string   "class_mon_n_ctrl_apps_unit_price_desc"
    t.decimal  "tc_srv_unit_price"
    t.string   "tc_srv_unit_price_desc"
    t.decimal  "web_srv_unit_price"
    t.string   "web_srv_unit_price_desc"
    t.decimal  "proxy_srv_unit_price"
    t.string   "proxy_srv_unit_price_desc"
    t.decimal  "file_n_print_srv_unit_price"
    t.string   "file_n_print_srv_unit_price_desc"
    t.decimal  "tc_lic_unit_price"
    t.string   "tc_lic_unit_price_desc"
    t.decimal  "spec_apps_unit_price"
    t.string   "spec_apps_unit_price_desc"
    t.decimal  "others_unit_price"
    t.string   "others_unit_price_desc"
    t.boolean  "free_soft_only"
    t.integer  "budget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "os_unit_price_curr",                    :default => 1
    t.integer  "office_suite_unit_price_curr",          :default => 1
    t.integer  "class_mon_n_ctrl_apps_unit_price_curr", :default => 1
    t.integer  "tc_srv_unit_price_curr",                :default => 1
    t.integer  "web_srv_unit_price_curr",               :default => 1
    t.integer  "proxy_srv_unit_price_curr",             :default => 1
    t.integer  "file_n_print_srv_unit_price_curr",      :default => 1
    t.integer  "tc_lic_unit_price_curr",                :default => 1
    t.integer  "spec_apps_unit_price_curr",             :default => 1
    t.integer  "others_unit_price_curr",                :default => 1
  end

  add_index "software", ["budget_id"], :name => "index_software_on_budget_id"

  create_table "workstations_settings", :force => true do |t|
    t.integer  "target"
    t.float    "ram_size_in_gigs"
    t.integer  "hd_size_in_gigs"
    t.decimal  "processor_unit_price",                  :precision => 8, :scale => 2
    t.string   "processor_unit_price_desc"
    t.decimal  "motherboard_unit_price",                :precision => 8, :scale => 2
    t.string   "motherboard_unit_price_desc"
    t.decimal  "power_supply_unit_price",               :precision => 8, :scale => 2
    t.string   "power_supply_unit_price_desc"
    t.decimal  "case_unit_price",                       :precision => 8, :scale => 2
    t.string   "case_unit_price_desc"
    t.decimal  "keyboard_unit_price",                   :precision => 8, :scale => 2
    t.string   "keyboard_unit_price_desc"
    t.decimal  "mouse_unit_price",                      :precision => 8, :scale => 2
    t.string   "mouse_unit_price_desc"
    t.decimal  "speakers_unit_price",                   :precision => 8, :scale => 2
    t.string   "speakers_unit_price_desc"
    t.decimal  "monitor_unit_price",                    :precision => 8, :scale => 2
    t.string   "monitor_unit_price_desc"
    t.decimal  "external_network_card_unit_price",      :precision => 8, :scale => 2
    t.string   "external_network_card_unit_price_desc"
    t.decimal  "external_video_card_unit_price",        :precision => 8, :scale => 2
    t.string   "external_video_card_unit_price_desc"
    t.decimal  "external_power_supply_unit_price",      :precision => 8, :scale => 2
    t.string   "external_power_supply_unit_price_desc"
    t.decimal  "extra1_unit_price",                     :precision => 8, :scale => 2
    t.string   "extra1_unit_price_desc"
    t.decimal  "extra2_unit_price",                     :precision => 8, :scale => 2
    t.string   "extra2_unit_price_desc"
    t.decimal  "extra3_unit_price",                     :precision => 8, :scale => 2
    t.string   "extra3_unit_price_desc"
    t.decimal  "extra4_unit_price",                     :precision => 8, :scale => 2
    t.string   "extra4_unit_price_desc"
    t.integer  "budget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "processor_unit_price_curr",                                           :default => 1
    t.integer  "motherboard_unit_price_curr",                                         :default => 1
    t.integer  "power_supply_unit_price_curr",                                        :default => 1
    t.integer  "case_unit_price_curr",                                                :default => 1
    t.integer  "keyboard_unit_price_curr",                                            :default => 1
    t.integer  "mouse_unit_price_curr",                                               :default => 1
    t.integer  "speakers_unit_price_curr",                                            :default => 1
    t.integer  "monitor_unit_price_curr",                                             :default => 1
    t.integer  "external_network_card_unit_price_curr",                               :default => 1
    t.integer  "external_video_card_unit_price_curr",                                 :default => 1
    t.integer  "external_power_supply_unit_price_curr",                               :default => 1
    t.integer  "extra1_unit_price_curr",                                              :default => 1
    t.integer  "extra2_unit_price_curr",                                              :default => 1
    t.integer  "extra3_unit_price_curr",                                              :default => 1
    t.integer  "extra4_unit_price_curr",                                              :default => 1
  end

  add_index "workstations_settings", ["budget_id"], :name => "index_workstations_settings_on_budget_id"

end
