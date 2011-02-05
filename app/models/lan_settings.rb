class LanSettings < ActiveRecord::Base
  
  include ARHelper if table_exists?
  
  belongs_to :budget

  validates_presence_of :ports_per_switch
  validates_numericality_of :ports_per_switch, :greater_than => 0, :allow_nil => true
  
  validates_length_of :ports_per_switch_desc, :in => 0..255, :allow_nil => true

  validates_presence_of :medium_distance_bt_pcs_switch
  validates_numericality_of :medium_distance_bt_pcs_switch, :greater_than => 0,
                            :allow_nil => true
                            
  validates_length_of :medium_distance_bt_pcs_switch_desc, :in => 0..255, :allow_nil => true

  validates_presence_of :installation_materials_and_wiring_cost
  validates_numericality_of :installation_materials_and_wiring_cost, :greater_than => 0,
                            :allow_nil => true
                            
  validates_length_of :installation_materials_and_wiring_cost_desc, :in => 0..255, 
                      :allow_nil => true
                      
  validates_inclusion_of :installation_materials_and_wiring_cost_curr, :in => Currency::AVAILABLE
                      
  after_initialize :init_attrs
                      
  def workstations_and_servers_count
    if budget.general_settings
      budget.general_settings.students_workstations_count+
      budget.general_settings.teachers_count+
      budget.general_settings.servers_count
    else
      0
    end
  end
  
  def switches_count
    (workstations_and_servers_count.to_f/ports_per_switch).ceil
  end
  
  def network_cable_meters_count
    medium_distance_bt_pcs_switch*workstations_and_servers_count
  end
  
  def switches_cost
    if budget.hardware_prices
      workstations_and_servers_count * 
        CurrencyConverter.eval(budget.hardware_prices, :switch_port_unit_price)
    else
      0
    end
  end
  
  def network_cable_cost
    if budget.hardware_prices
      network_cable_meters_count * 
        CurrencyConverter.eval(budget.hardware_prices, :network_cable_unit_price)
    else
      0
    end
  end
  
  def rj45_connectors_cost
    if budget.hardware_prices
      2*workstations_and_servers_count * 
        CurrencyConverter.eval(budget.hardware_prices, :rj45_connector_unit_price)
    else
      0
    end
  end
  
  def total_cost
    switches_cost+network_cable_cost+
      rj45_connectors_cost+
      CurrencyConverter.eval(self, :installation_materials_and_wiring_cost)
  end
  
  protected
  
  def init_attrs
    if new_record?
      self.ports_per_switch = Conf.lan_settings['ports_per_switch'] unless ports_per_switch
      self.medium_distance_bt_pcs_switch = Conf.lan_settings['medium_distance_bt_pcs_switch'] unless medium_distance_bt_pcs_switch
      self.installation_materials_and_wiring_cost = Conf.lan_settings['installation_materials_and_wiring_cost'] unless installation_materials_and_wiring_cost
    end
  end
  
end
