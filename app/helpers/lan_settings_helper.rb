module LanSettingsHelper
  
  def ls_workstations_and_servers_count_desc(budget)
    ["#{GeneralSettings.human_attribute_name('students_workstations_count')} (#{budget.general_settings ? budget.general_settings.students_workstations_count : 0})",
    "#{GeneralSettings.human_attribute_name('teachers_count')} (#{budget.general_settings ? budget.general_settings.teachers_count : 0})",
    "#{GeneralSettings.human_attribute_name('servers_count')} (#{budget.general_settings ? budget.general_settings.servers_count : 0})"]
  end
  
  def ls_switches_count_desc(l_settings)
    ["#{LanSettings.human_attribute_name('workstations_and_servers_count')} (#{l_settings.workstations_and_servers_count})",
    "#{LanSettings.human_attribute_name('ports_per_switch')} (#{l_settings.ports_per_switch})"]
  end
  
  def ls_network_cable_meters_count_desc(l_settings)
    ["#{LanSettings.human_attribute_name('workstations_and_servers_count')} (#{l_settings.workstations_and_servers_count})",
    "#{LanSettings.human_attribute_name('medium_distance_bt_pcs_switch')} (#{l_settings.medium_distance_bt_pcs_switch})"]
  end
  
  def ls_switches_cost_desc(budget)
    ["#{LanSettings.human_attribute_name('workstations_and_servers_count')} (#{budget.lan_settings.workstations_and_servers_count})",
    "#{HardwarePrices.human_attribute_name('switch_port_unit_price')} (#{number_to_currency(budget.hardware_prices ? budget.hardware_prices.switch_port_unit_price : 0)})"]
  end
  
  def ls_network_cable_cost_desc(budget)
    ["#{LanSettings.human_attribute_name('network_cable_meters_count')} (#{budget.lan_settings.network_cable_meters_count})",
    "#{HardwarePrices.human_attribute_name('network_cable_unit_price')} #{number_to_currency(budget.hardware_prices ? budget.hardware_prices.network_cable_unit_price : 0)}"]
  end
  
  def ls_rj45_connectors_cost_desc(budget)
    ["2",
    "#{LanSettings.human_attribute_name('workstations_and_servers_count')} (#{budget.lan_settings.workstations_and_servers_count})",
    "#{HardwarePrices.human_attribute_name('rj45_connector_unit_price')} (#{number_to_currency(budget.hardware_prices ? budget.hardware_prices.rj45_connector_unit_price : 0)})"]
  end
  
  def ls_total_cost_desc(l_settings)
    ["#{LanSettings.human_attribute_name('switches_cost')} (#{number_to_currency l_settings.switches_cost})",
    "#{LanSettings.human_attribute_name('network_cable_cost')} (#{number_to_currency l_settings.network_cable_cost})",
    "#{LanSettings.human_attribute_name('rj45_connectors_cost')} (#{number_to_currency l_settings.rj45_connectors_cost})",
    "#{LanSettings.human_attribute_name('installation_materials_and_wiring_cost')} (#{nbr_to_curr l_settings, :installation_materials_and_wiring_cost})"]
  end
  
  def ls_reference_values(lan_settings)
    # ITEM, UNIT PRICE.
    items = []
    items << [LanSettings.human_attribute_name('ports_per_switch').humanize, 
              lan_settings.ports_per_switch]
    items << [LanSettings.human_attribute_name('medium_distance_bt_pcs_switch').humanize, 
              lan_settings.medium_distance_bt_pcs_switch]
    items << [LanSettings.human_attribute_name('installation_materials_and_wiring_cost').humanize, 
              nbr_to_curr(lan_settings, :installation_materials_and_wiring_cost)]
              
    remove_zeros items
  end
  
end
