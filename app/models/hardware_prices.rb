class HardwarePrices < ActiveRecord::Base

  include ARHelper if table_exists?

  belongs_to :budget

  validates_presence_of :ram_unit_price
  validates_numericality_of :ram_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :ram_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :ram_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :hd_unit_price
  validates_numericality_of :hd_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :hd_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :hd_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :network_cable_unit_price
  validates_numericality_of :network_cable_unit_price, 
                            :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :network_cable_unit_price_desc, :in => 0..255, 
                      :allow_nil => true
  
  validates_inclusion_of :network_cable_unit_price_curr, 
                          :in => Currency::AVAILABLE

  validates_presence_of :switch_port_unit_price
  validates_numericality_of :switch_port_unit_price, 
                            :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :switch_port_unit_price_desc, :in => 0..255, 
                      :allow_nil => true
  
  validates_inclusion_of :switch_port_unit_price_curr, 
                         :in => Currency::AVAILABLE

  validates_presence_of :printer_unit_price
  validates_numericality_of :printer_unit_price, 
                            :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :printer_unit_price_desc, :in => 0..255, 
                      :allow_nil => true
  
  validates_inclusion_of :printer_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :scanner_unit_price
  validates_numericality_of :scanner_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :scanner_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :scanner_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :rj45_connector_unit_price
  validates_numericality_of :rj45_connector_unit_price, 
                            :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :rj45_connector_unit_price_desc, :in => 0..255, 
                      :allow_nil => true
  
  validates_inclusion_of :rj45_connector_unit_price_curr, 
                         :in => Currency::AVAILABLE
  
  validates_presence_of :ups_unit_price
  validates_numericality_of :ups_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :ups_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :ups_unit_price_curr, :in => Currency::AVAILABLE
  
  after_initialize :init_attrs
  
  def self.price_cols
    HardwarePrices.column_names.select { |col| 
      col =~ /_unit_price$/
    }
  end
  
  protected
  
  def init_attrs
    if new_record?
      HardwarePrices.price_cols.each do |col|
        send "#{col}=", Conf.hardware_prices[col] unless send(col)
      end
    end
  end
  
end
