class AddXxxCurrToModels < ActiveRecord::Migration
  def self.up
    change_table(:hardware_prices) do |t|
      t.integer :ram_unit_price_curr, :default => Currency::DEFAULT
      t.integer :hd_unit_price_curr, :default => Currency::DEFAULT
      t.integer :network_cable_unit_price_curr, :default => Currency::DEFAULT
      t.integer :switch_port_unit_price_curr, :default => Currency::DEFAULT
      t.integer :laser_printer_price_curr, :default => Currency::DEFAULT
      t.integer :scanner_price_curr, :default => Currency::DEFAULT
      t.integer :rj45_connector_unit_price_curr, :default => Currency::DEFAULT
      t.integer :ups_price_curr, :default => Currency::DEFAULT
    end
    
    change_table(:workstations_settings) do |t|
      t.integer :processor_unit_price_curr, :default => Currency::DEFAULT
      t.integer :motherboard_unit_price_curr, :default => Currency::DEFAULT
      t.integer :power_supply_unit_price_curr, :default => Currency::DEFAULT
      t.integer :case_unit_price_curr, :default => Currency::DEFAULT
      t.integer :keyboard_unit_price_curr, :default => Currency::DEFAULT
      t.integer :mouse_unit_price_curr, :default => Currency::DEFAULT
      t.integer :speakers_unit_price_curr, :default => Currency::DEFAULT
      t.integer :monitor_unit_price_curr, :default => Currency::DEFAULT
      t.integer :external_network_card_unit_price_curr, :default => Currency::DEFAULT
      t.integer :external_video_card_unit_price_curr, :default => Currency::DEFAULT
      t.integer :external_power_supply_unit_price_curr, :default => Currency::DEFAULT
      t.integer :extra1_unit_price_curr, :default => Currency::DEFAULT
      t.integer :extra2_unit_price_curr, :default => Currency::DEFAULT
      t.integer :extra3_unit_price_curr, :default => Currency::DEFAULT
      t.integer :extra4_unit_price_curr, :default => Currency::DEFAULT
    end
    
    change_table(:lan_settings) do |t|
      t.integer :installation_materials_and_wiring_cost_curr, :default => Currency::DEFAULT
    end
    
    change_table(:software) do |t|
      t.integer :os_curr, :default => Currency::DEFAULT
      t.integer :office_suite_curr, :default => Currency::DEFAULT
      t.integer :class_monitoring_n_ctrl_apps_curr, :default => Currency::DEFAULT
      t.integer :tc_server_curr, :default => Currency::DEFAULT
      t.integer :web_server_curr, :default => Currency::DEFAULT
      t.integer :proxy_server_curr, :default => Currency::DEFAULT
      t.integer :file_n_printing_server_curr, :default => Currency::DEFAULT
      t.integer :tc_license_curr, :default => Currency::DEFAULT
      t.integer :specialized_apps_curr, :default => Currency::DEFAULT
      t.integer :others_curr, :default => Currency::DEFAULT
    end
    
    [HardwarePrices, WorkstationsSettings, LanSettings, Software].each do |clazz|
      sql = clazz.column_names.select { |col|
        col =~ /_curr$/
      }.map { |col|
        "#{col} = #{Currency::DEFAULT}"
      }.join ', '
      clazz.update_all sql
    end
  end

  def self.down
    change_table(:hardware_prices) do |t|
      t.remove :ram_unit_price_curr
      t.remove :hd_unit_price_curr
      t.remove :network_cable_unit_price_curr
      t.remove :switch_port_unit_price_curr
      t.remove :laser_printer_price_curr
      t.remove :scanner_price_curr
      t.remove :rj45_connector_unit_price_curr
      t.remove :ups_price_curr
    end
    
    change_table(:workstations_settings) do |t|
      t.remove :processor_unit_price_curr
      t.remove :motherboard_unit_price_curr
      t.remove :power_supply_unit_price_curr
      t.remove :case_unit_price_curr
      t.remove :keyboard_unit_price_curr
      t.remove :mouse_unit_price_curr
      t.remove :speakers_unit_price_curr
      t.remove :monitor_unit_price_curr
      t.remove :external_network_card_unit_price_curr
      t.remove :external_video_card_unit_price_curr
      t.remove :external_power_supply_unit_price_curr
      t.remove :extra1_unit_price_curr
      t.remove :extra2_unit_price_curr
      t.remove :extra3_unit_price_curr
      t.remove :extra4_unit_price_curr
    end
    
    change_table(:lan_settings) do |t|
      t.remove :installation_materials_and_wiring_cost_curr
    end
    
    change_table(:software) do |t|
      t.remove :os_curr
      t.remove :office_suite_curr
      t.remove :class_monitoring_n_ctrl_apps_curr
      t.remove :tc_server_curr
      t.remove :web_server_curr
      t.remove :proxy_server_curr
      t.remove :file_n_printing_server_curr
      t.remove :tc_license_curr
      t.remove :specialized_apps_curr
      t.remove :others_curr
    end
  end
end
