module SoftwareHelper
  
  def target_desc(target)
    case target
      when Software::Target::STUDENTS_STANDALONE then t('msgs.students_software')
      when Software::Target::TEACHERS_STANDALONE then t('msgs.teachers_software')
      when Software::Target::TC_SERVER then t('msgs.servers_software')
      when Software::Target::TC then t('msgs.tc_software')
      else ''
    end
  end
  
  def soft_total_cost_desc(software)
    software.price_cols.map do |col|
      "#{Software.human_attribute_name(col)} (#{nbr_to_curr software, col})"
    end
  end
  
  def soft_reference_values(software)
    # ITEM, UNIT PRICE.
    items = software.price_cols.map do |price_col|
      [Software.human_attribute_name(price_col).humanize, 
      nbr_to_curr(software, price_col)]
    end
    
    remove_zeros items
  end
  
end
