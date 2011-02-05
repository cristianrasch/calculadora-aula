module GeneralSettingsHelper
  
  def gs_reference_values(settings)
    # ITEM, UNIT PRICE.
    items = []
    items << [GeneralSettings.human_attribute_name('students_per_workstation').humanize, 
              settings.students_per_workstation]
    items << [GeneralSettings.human_attribute_name('clients_per_server').humanize, 
              settings.clients_per_server]
              
    remove_zeros items
  end
  
end
