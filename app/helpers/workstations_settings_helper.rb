module WorkstationsSettingsHelper

  def target_desc(target)
    case target
      when WorkstationsSettings::Target::STUDENTS then t('msgs.students_workstations')
      when WorkstationsSettings::Target::TEACHERS then t('msgs.teachers_workstations')
      when WorkstationsSettings::Target::SERVERS then t('msgs.servers_workstations')
      when WorkstationsSettings::Target::THIN_CLIENTS then t('msgs.thin_clients_workstations')
      else ''
    end
  end
  
  def ws_total_cost_desc(ws_settings)
    %w{ram hd}.map { |col|
      params = curr_params ws_settings.budget.hardware_prices, "#{col}_unit_price"
      col_cost = "#{col}_cost"
      "#{WorkstationsSettings.human_attribute_name(col_cost)} (#{number_to_currency ws_settings.send(col_cost), :unit => params[:unit], :separator => params[:separator]})"
    } +
    WorkstationsSettings.price_cols.map { |col|
      "#{WorkstationsSettings.human_attribute_name(col)} (#{nbr_to_curr ws_settings, col})"
    }
  end
  
  def ws_reference_values(ws_settings)
    # ITEM, UNIT PRICE.
    items = []
    items << [WorkstationsSettings.human_attribute_name('ram_size_in_gigs').humanize, 
              ws_settings.ram_size_in_gigs]
    items << [WorkstationsSettings.human_attribute_name('hd_size_in_gigs').humanize, 
              ws_settings.hd_size_in_gigs]
    items << [WorkstationsSettings.human_attribute_name('processor_unit_price').humanize, 
              nbr_to_curr(ws_settings, :processor_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('motherboard_unit_price').humanize, 
              nbr_to_curr(ws_settings, :motherboard_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('power_supply_unit_price').humanize, 
              nbr_to_curr(ws_settings, :power_supply_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('case_unit_price').humanize, 
              nbr_to_curr(ws_settings, :case_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('keyboard_unit_price').humanize, 
              nbr_to_curr(ws_settings, :keyboard_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('mouse_unit_price').humanize, 
              nbr_to_curr(ws_settings, :mouse_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('speakers_unit_price').humanize, 
              nbr_to_curr(ws_settings, :speakers_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('monitor_unit_price').humanize, 
              nbr_to_curr(ws_settings, :monitor_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('external_network_card_unit_price').humanize, 
              nbr_to_curr(ws_settings, :external_network_card_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('external_video_card_unit_price').humanize, 
              nbr_to_curr(ws_settings, :external_video_card_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('external_power_supply_unit_price').humanize, 
              nbr_to_curr(ws_settings, :external_power_supply_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('extra1_unit_price').humanize, 
              nbr_to_curr(ws_settings, :extra1_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('extra2_unit_price').humanize, 
              nbr_to_curr(ws_settings, :extra2_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('extra3_unit_price').humanize, 
              nbr_to_curr(ws_settings, :extra3_unit_price)]
    items << [WorkstationsSettings.human_attribute_name('extra4_unit_price').humanize, 
              nbr_to_curr(ws_settings, :extra4_unit_price)]
              
    remove_zeros items
  end

end
