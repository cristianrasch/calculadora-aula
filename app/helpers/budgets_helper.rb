module BudgetsHelper
  
  def to_table budget
    # ITEM, DESCRIPTION, UNIT PRICE, QUANTITY, SUBTOTAL.
    items = []
    if budget.settings.students_standalone_workstations_enabled &&
        budget.settings.students_standalone_workstations_cost > 0
      item = Settings.human_attribute_name 'students_standalone_workstations_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.students_workstations_settings.total_cost), 
                budget.general_settings.students_workstations_count,
                number_to_currency(budget.settings.students_standalone_workstations_cost)]
    end
    
    if budget.settings.teachers_standalone_workstations_enabled &&
        budget.settings.teachers_standalone_workstations_cost > 0
      item = Settings.human_attribute_name 'teachers_standalone_workstations_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.teachers_workstations_settings.total_cost), 
                budget.general_settings.teachers_count,
                number_to_currency(budget.settings.teachers_standalone_workstations_cost)]
    end
    
    if budget.settings.thin_clients_enabled &&
        budget.settings.thin_clients_cost > 0
      item = Settings.human_attribute_name 'thin_clients_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.thin_clients_workstations_settings.total_cost), 
                budget.general_settings.students_workstations_count,
                number_to_currency(budget.settings.thin_clients_cost)]
    end
    
    if budget.settings.thin_clients_server_enabled &&
        budget.settings.thin_clients_server_cost > 0
      item = Settings.human_attribute_name 'thin_clients_server_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.servers_workstations_settings.total_cost), 
                budget.general_settings.servers_count,
                number_to_currency(budget.settings.thin_clients_server_cost)]
    end
    
    if budget.settings.lan_enabled &&
        budget.settings.lan_cost > 0
      item = Settings.human_attribute_name 'lan_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.lan_settings.total_cost), 
                1,
                number_to_currency(budget.lan_settings.total_cost)]
    end
    
    if budget.settings.printers_count > 0 &&
        budget.settings.printers_cost > 0
      items << [t('msgs.printers').humanize, 
                '...', 
                nbr_to_curr(budget.hardware_prices, :printer_unit_price), 
                budget.settings.printers_count,
                number_to_currency(budget.settings.printers_cost)]
    end
    
    if budget.settings.scanners_count > 0 &&
        budget.settings.scanners_cost > 0
      items << [t('msgs.scanners').humanize, 
                '...', 
                nbr_to_curr(budget.hardware_prices, :scanner_unit_price), 
                budget.settings.scanners_count,
                number_to_currency(budget.settings.scanners_cost)]
    end
    
    if budget.settings.students_furnishings_enabled &&
        budget.settings.students_furnishings_cost > 0
      item = Settings.human_attribute_name 'students_furnishings_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.students_furnishings.total_cost), 
                budget.general_settings.students_workstations_count,
                number_to_currency(budget.settings.students_furnishings_cost)]
    end
    
    if budget.settings.teachers_furnishings_enabled &&
        budget.settings.teachers_furnishings_cost > 0
      item = Settings.human_attribute_name 'teachers_furnishings_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.teachers_furnishings.total_cost), 
                budget.general_settings.teachers_count,
                number_to_currency(budget.settings.teachers_furnishings_cost)]
    end
    
    if budget.settings.servers_furnishings_enabled &&
        budget.settings.servers_furnishings_cost > 0
      item = Settings.human_attribute_name 'servers_furnishings_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.servers_furnishings.total_cost), 
                budget.general_settings.servers_count,
                number_to_currency(budget.settings.servers_furnishings_cost)]
    end
    
    if budget.settings.prop_students_soft_enabled? &&
        budget.settings.students_software_cost > 0
      item = Settings.human_attribute_name 'prop_students_soft_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.students_standalone_software.total_cost), 
                budget.general_settings.students_workstations_count,
                number_to_currency(budget.settings.students_software_cost)]
    end
    
    if budget.settings.prop_teachers_soft_enabled? &&
        budget.settings.teachers_software_cost > 0
      item = Settings.human_attribute_name 'prop_teachers_soft_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.teachers_standalone_software.total_cost), 
                budget.general_settings.teachers_count,
                number_to_currency(budget.settings.teachers_software_cost)]
    end
    
    if budget.settings.prop_tc_soft_enabled? &&
        budget.settings.tc_software_cost > 0
      item = Settings.human_attribute_name 'prop_tc_soft_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.tc_software.total_cost), 
                budget.general_settings.students_workstations_count,
                number_to_currency(budget.settings.tc_software_cost)]
    end
    
    if budget.settings.prop_tc_server_soft_enabled? &&
        budget.settings.tc_server_software_cost > 0
      item = Settings.human_attribute_name 'prop_tc_server_soft_enabled'
      item = item[0, item.rindex(' ')].humanize
      
      items << [item, 
                '...', 
                number_to_currency(budget.tc_server_software.total_cost), 
                budget.general_settings.servers_count,
                number_to_currency(budget.settings.tc_server_software_cost)]
    end
    
    if budget.settings.building_improvements_cost > 0
      items << [Settings.human_attribute_name('building_improvements_cost').humanize, 
                '...', 
                number_to_currency(budget.settings.building_improvements_cost), 
                1,
                number_to_currency(budget.settings.building_improvements_cost)]
    end
    
    if budget.settings.electric_installation_cost > 0
      items << [Settings.human_attribute_name('electric_installation_cost').humanize, 
                '...', 
                number_to_currency(budget.settings.electric_installation_cost), 
                1,
                number_to_currency(budget.settings.electric_installation_cost)]
    end
    
    items
  end
  
end
