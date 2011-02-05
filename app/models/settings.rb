class Settings < ActiveRecord::Base

  include ARHelper if table_exists?

  belongs_to :budget
  
  validates_inclusion_of :students_standalone_workstations_enabled, 
                         :in => [true, false]
  
  validates_inclusion_of :teachers_standalone_workstations_enabled,
                         :in => [true, false]
  
  validates_inclusion_of :thin_clients_enabled,
                         :in => [true, false]
  
  validates_inclusion_of :thin_clients_server_enabled,
                         :in => [true, false]
  
  validates_inclusion_of :lan_enabled,
                         :in => [true, false]
  
  validates_inclusion_of :ups_enabled,
                         :in => [true, false]
  
  validates_presence_of :printers_count
  validates_numericality_of :printers_count, :greater_than_or_equal_to => 0,
                            :allow_nil => true
  
  validates_presence_of :scanners_count
  validates_numericality_of :scanners_count, :greater_than_or_equal_to => 0,
                            :allow_nil => true
  
  validates_inclusion_of :students_furnishings_enabled,
                         :in => [true, false]
  
  validates_inclusion_of :teachers_furnishings_enabled,
                         :in => [true, false]
  
  validates_inclusion_of :servers_furnishings_enabled,
                         :in => [true, false]
  
  validates_presence_of :building_improvements_cost
  validates_numericality_of :building_improvements_cost, 
                            :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :building_improvements_cost_desc, :in => 0..255, :allow_nil => true
  
  validates_presence_of :electric_installation_cost
  validates_numericality_of :electric_installation_cost, 
                            :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :electric_installation_cost_desc, :in => 0..255, :allow_nil => true
  
  after_initialize :init_attrs
  
  def students_standalone_workstations_cost
    if students_standalone_workstations_enabled &&
        budget.general_settings &&
        budget.students_workstations_settings
      budget.general_settings.students_workstations_count*budget.students_workstations_settings.total_cost
    else
      0
    end
  end
  
  def teachers_standalone_workstations_cost
    if teachers_standalone_workstations_enabled &&
        budget.general_settings &&
        budget.teachers_workstations_settings
      budget.general_settings.teachers_count*budget.teachers_workstations_settings.total_cost
    else
      0
    end
  end
  
  def thin_clients_cost
    if thin_clients_enabled &&
        budget.general_settings &&
        budget.thin_clients_workstations_settings
      budget.general_settings.students_workstations_count*budget.thin_clients_workstations_settings.total_cost
    else
      0
    end
  end
  
  def thin_clients_server_cost
    if thin_clients_server_enabled &&
        budget.general_settings &&
        budget.servers_workstations_settings
      budget.general_settings.servers_count*budget.servers_workstations_settings.total_cost
    else
      0
    end
  end
  
  def lan_cost
    budget.lan_settings ? budget.lan_settings.total_cost: 0
  end
  
  def ups_cost
    if ups_enabled && budget.general_settings && budget.hardware_prices
      budget.general_settings.servers_count * 
        CurrencyConverter.eval(budget.hardware_prices, :ups_unit_price)
    else
      0
    end
  end
  
  def printers_cost
    if budget.hardware_prices
      printers_count * 
        CurrencyConverter.eval(budget.hardware_prices, :printer_unit_price)
    else
      0
    end
  end
  
  def scanners_cost
    if budget.hardware_prices
      scanners_count * 
        CurrencyConverter.eval(budget.hardware_prices, :scanner_unit_price)
    else
      0
    end
  end
  
  def students_furnishings_cost
    if budget.general_settings &&
        budget.students_furnishings
      budget.general_settings.students_workstations_count*budget.students_furnishings.total_cost
    else
      0
    end
  end
  
  def teachers_furnishings_cost
    if budget.general_settings &&
        budget.teachers_furnishings
      budget.general_settings.teachers_count*budget.teachers_furnishings.total_cost
    else
      0
    end
  end
  
  def servers_furnishings_cost
    if budget.general_settings &&
        budget.servers_furnishings
      budget.general_settings.servers_count*budget.servers_furnishings.total_cost
    else
      0
    end
  end
  
  def students_software_cost
    if students_standalone_workstations_enabled &&
        budget.general_settings &&
        budget.students_standalone_software
      budget.general_settings.students_workstations_count*budget.students_standalone_software.total_cost
    else
      0
    end
  end
  
  def teachers_software_cost
    if teachers_standalone_workstations_enabled &&
        budget.general_settings &&
        budget.teachers_standalone_software
      budget.general_settings.teachers_count*budget.teachers_standalone_software.total_cost
    else
      0
    end
  end
  
  def tc_server_software_cost
    if thin_clients_server_enabled &&
        budget.general_settings &&
        budget.tc_server_software
      budget.general_settings.servers_count*budget.tc_server_software.total_cost
    else
      0
    end
  end
  
  def tc_software_cost
    if thin_clients_enabled &&
        budget.general_settings &&
        budget.tc_software
      budget.general_settings.students_workstations_count*budget.tc_software.total_cost
    else
      0
    end
  end
  
  def prop_students_soft_enabled?
    !! (budget.students_standalone_software && 
      ! budget.students_standalone_software.free_soft_only)
  end
  
  def prop_teachers_soft_enabled?
    !! (budget.teachers_standalone_software &&
      ! budget.teachers_standalone_software.free_soft_only)
  end
  
  def prop_tc_server_soft_enabled?
    !! (budget.tc_server_software &&
      ! budget.tc_server_software.free_soft_only)
  end
  
  def prop_tc_soft_enabled?
    !! (budget.tc_software && ! budget.tc_software.free_soft_only)
  end
  
  def total_cost
    students_standalone_workstations_cost+
    teachers_standalone_workstations_cost+
    thin_clients_cost+
    thin_clients_server_cost+
    lan_cost+
    ups_cost+
    printers_cost+
    scanners_cost+
    students_furnishings_cost+
    teachers_furnishings_cost+
    servers_furnishings_cost+
    students_software_cost+
    teachers_software_cost+
    tc_server_software_cost+
    tc_software_cost
  end
  
  protected
  
  def self.switch_cols
    Settings.column_names.select { |col| 
      col =~ /_enabled$/
    }
  end
  
  def self.count_n_cost_cols
    Settings.column_names.select { |col| 
      col =~ /_(count|cost)$/
    }
  end
  
  def init_attrs
    if new_record?
      Settings.switch_cols.each do |col|
        send "#{col}=", Conf.settings[col] if send(col).nil?
      end
      
      Settings.count_n_cost_cols.each do |col|
        send "#{col}=", Conf.settings[col] unless send col
      end
    end
  end
  
end
