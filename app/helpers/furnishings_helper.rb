module FurnishingsHelper

  def target_desc(target)
    case target
      when Furnishings::Target::STUDENTS then t('msgs.students_furnishings')
      when Furnishings::Target::TEACHERS then t('msgs.teachers_furnishings')
      when Furnishings::Target::SERVERS then t('msgs.servers_furnishings')
      else ''
    end
  end
  
  def f_total_cost_desc(furnishings)
    %w{chairs_cost tables_cost others_cost}.map do |col|
      Furnishings.human_attribute_name(col)+" ("+number_to_currency(furnishings.send(col))+")"
    end
  end

  def f_reference_values(furnishings)
    # ITEM, UNIT PRICE.
    items = []
    items << [Furnishings.human_attribute_name('chairs_unit_price').humanize, 
              number_to_currency(furnishings.chairs_unit_price)]
    items << [Furnishings.human_attribute_name('chairs_per_workstation').humanize, 
              furnishings.chairs_per_workstation]
    items << [Furnishings.human_attribute_name('tables_unit_price').humanize, 
              number_to_currency(furnishings.tables_unit_price)]
    items << [Furnishings.human_attribute_name('tables_per_workstation').humanize, 
              furnishings.tables_per_workstation]
    items << [Furnishings.human_attribute_name('others_unit_price').humanize, 
              number_to_currency(furnishings.others_unit_price)]
    items << [Furnishings.human_attribute_name('others_per_workstation').humanize, 
              furnishings.others_per_workstation]
              
    remove_zeros items
  end

end
