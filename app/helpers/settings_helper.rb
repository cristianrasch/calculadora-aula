module SettingsHelper
  
  def s_students_standalone_workstations_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('students_workstations_count')} (#{budget.general_settings ? budget.general_settings.students_workstations_count : 0})",
    "costo de las #{Budget.human_attribute_name('students_workstations_settings')} (#{number_to_currency(budget.students_workstations_settings ? budget.students_workstations_settings.total_cost : 0)})"]
  end
  
  def s_teachers_standalone_workstations_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('teachers_count')} (#{budget.general_settings ? budget.general_settings.teachers_count : 0})",
    "costo de las #{Budget.human_attribute_name('teachers_workstations_settings')} (#{number_to_currency(budget.teachers_workstations_settings ? budget.teachers_workstations_settings.total_cost : 0)})"]
  end
  
  def s_thin_clients_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('students_workstations_count')} (#{budget.general_settings ? budget.general_settings.students_workstations_count : 0})",
    "costo de las #{Budget.human_attribute_name('thin_clients_workstations_settings')} (#{number_to_currency(budget.thin_clients_workstations_settings ? budget.thin_clients_workstations_settings.total_cost : 0)})"]
  end
  
  def s_thin_clients_server_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('servers_count')} (#{budget.general_settings ? budget.general_settings.servers_count : 0})",
    "costo de las #{Budget.human_attribute_name('servers_workstations_settings')} (#{number_to_currency(budget.servers_workstations_settings ? budget.servers_workstations_settings.total_cost : 0)})"]
  end
  
  def s_ups_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('servers_count')} (#{budget.general_settings ? budget.general_settings.servers_count : 0})",
    "#{HardwarePrices.human_attribute_name('ups_unit_price')} (#{number_to_currency(budget.hardware_prices ? budget.hardware_prices.ups_unit_price : 0)})"]
  end
  
  def s_printers_cost_desc(budget)
    ["#{Settings.human_attribute_name('printers_count')} (#{budget.settings.printers_count})",
    "#{HardwarePrices.human_attribute_name('printer_unit_price')} (#{number_to_currency(budget.hardware_prices ? budget.hardware_prices.printer_unit_price : 0)})"]
  end
  
  def s_scanners_cost_desc(budget)
    ["#{Settings.human_attribute_name('scanners_count')} (#{budget.settings.scanners_count})",
    "#{HardwarePrices.human_attribute_name('scanner_unit_price')} (#{number_to_currency(budget.hardware_prices ? budget.hardware_prices.scanner_unit_price : 0)})"]
  end
  
  def s_students_furnishings_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('students_workstations_count')} (#{budget.general_settings ? budget.general_settings.students_workstations_count : 0})",
    "costo del #{I18n.t('msgs.students_furnishings')} (#{number_to_currency budget.settings.students_furnishings_cost})"]
  end
  
  def s_teachers_furnishings_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('teachers_count')} (#{budget.teachers_furnishings ? budget.general_settings.teachers_count : 0})",
    "costo del #{I18n.t('msgs.teachers_furnishings')} (#{number_to_currency budget.settings.teachers_furnishings_cost})"]
  end
  
  def s_servers_furnishings_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('servers_count')} (#{budget.general_settings ? budget.general_settings.servers_count : 0})",
    "costo del #{I18n.t('msgs.servers_furnishings')} (#{number_to_currency budget.settings.servers_furnishings_cost})"]
  end
  
  def s_students_software_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('students_workstations_count')} (#{budget.general_settings ? budget.general_settings.students_workstations_count : 0})",
    "costo del #{Budget.human_attribute_name('students_standalone_software')} (#{number_to_currency budget.settings.students_software_cost})"]
  end
  
  def s_teachers_software_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('teachers_count')} (#{budget.general_settings ? budget.general_settings.teachers_count : 0})",
    "costo del #{Budget.human_attribute_name('teachers_standalone_software')} (#{number_to_currency budget.settings.teachers_software_cost})"]
  end
  
  def s_tc_server_software_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('servers_count')} (#{budget.general_settings ? budget.general_settings.servers_count : 0})",
    "costo del #{Budget.human_attribute_name('tc_server_software')} (#{number_to_currency budget.settings.tc_server_software_cost})"]
  end
  
  def s_tc_software_cost_desc(budget)
    ["#{GeneralSettings.human_attribute_name('students_workstations_count')} (#{budget.general_settings ? budget.general_settings.students_workstations_count : 0})",
    "costo del #{Budget.human_attribute_name('tc_software')} (#{number_to_currency budget.settings.tc_software_cost})"]
  end
  
  def s_total_cost_desc(budget)
    settings = budget.settings
    arr = []
    
    %w{students_standalone_workstations teachers_standalone_workstations thin_clients thin_clients_server lan ups students_furnishings teachers_furnishings servers_furnishings}.each do |col|
      if settings.send "#{col}_enabled"
        item = Settings.human_attribute_name "#{col}_enabled"
        item = item[0, item.rindex(' ')]
        arr << item+" ("+number_to_currency(settings.send("#{col}_cost"))+")"
      end
    end
    
    %w{printers scanners}.each do |col|
      if settings.send("#{col}_count") > 0 &&
          settings.send("#{col}_cost") > 0
        item = Settings.human_attribute_name "#{col}_count"
        item = item[item.rindex(' ')+1, item.length-item.rindex(' ')]
        arr << "#{item} ("+number_to_currency(settings.send("#{col}_cost"))+")"
      end
    end
    
    %w{students_soft teachers_soft tc_server_soft tc_soft}.each do |col|
      if settings.send("prop_#{col}_enabled?") && settings.send("#{col}ware_cost") > 0
        item = Settings.human_attribute_name "prop_#{col}_enabled"
        item = item[0, item.rindex(' ')]
        arr << item+" ("+number_to_currency(settings.send("#{col}ware_cost"))+")"
      end
    end
    
    arr
  end
  
  def s_reference_values(settings)
    # ITEM, UNIT PRICE.
    items = []
    items << [Settings.human_attribute_name('students_standalone_workstations_enabled').humanize, 
              (t(settings.students_standalone_workstations_enabled ? 'msgs.yes_txt' : 'msgs.no_txt')).humanize]
    items << [Settings.human_attribute_name('teachers_standalone_workstations_enabled').humanize, 
              (t(settings.teachers_standalone_workstations_enabled ? 'msgs.yes_txt' : 'msgs.no_txt')).humanize]
    items << [Settings.human_attribute_name('thin_clients_enabled').humanize, 
              (t(settings.thin_clients_enabled ? 'msgs.yes_txt' : 'msgs.no_txt')).humanize]
    items << [Settings.human_attribute_name('thin_clients_server_enabled').humanize, 
              (t(settings.thin_clients_server_enabled ? 'msgs.yes_txt' : 'msgs.no_txt')).humanize]
    items << [Settings.human_attribute_name('lan_enabled').humanize, 
              (t(settings.lan_enabled ? 'msgs.yes_txt' : 'msgs.no_txt')).humanize]
    items << [Settings.human_attribute_name('ups_enabled').humanize, 
              (t(settings.ups_enabled ? 'msgs.yes_txt' : 'msgs.no_txt')).humanize]
    items << [Settings.human_attribute_name('printers_count').humanize, 
              settings.printers_count]
    items << [Settings.human_attribute_name('scanners_count').humanize, 
              settings.scanners_count]
    items << [Settings.human_attribute_name('students_furnishings_enabled').humanize, 
              (t(settings.students_furnishings_enabled ? 'msgs.yes_txt' : 'msgs.no_txt')).humanize]
    items << [Settings.human_attribute_name('teachers_furnishings_enabled').humanize, 
              (t(settings.teachers_furnishings_enabled ? 'msgs.yes_txt' : 'msgs.no_txt')).humanize]
    items << [Settings.human_attribute_name('servers_furnishings_enabled').humanize, 
              (t(settings.servers_furnishings_enabled ? 'msgs.yes_txt' : 'msgs.no_txt')).humanize]
    items << [Settings.human_attribute_name('building_improvements_cost').humanize, 
              number_to_currency(settings.building_improvements_cost)]
    items << [Settings.human_attribute_name('electric_installation_cost').humanize, 
              number_to_currency(settings.electric_installation_cost)]
    
    remove_zeros items
  end
  
end
