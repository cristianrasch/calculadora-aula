class WorkstationsSettings < ActiveRecord::Base

  include ARHelper if table_exists?
  
  class Target
    STUDENTS = 1
    TEACHERS = 2
    SERVERS = 3
    THIN_CLIENTS = 4
  end

  belongs_to :budget

  validates_presence_of :target
  validates_inclusion_of :target, :in => Target::STUDENTS..Target::THIN_CLIENTS,
                         :allow_nil => true
  validates_uniqueness_of :target, :scope => :budget_id, :allow_nil => true

  validates_presence_of :ram_size_in_gigs
  validates_numericality_of :ram_size_in_gigs, :greater_than => 0, 
                            :allow_nil => true

  validates_presence_of :hd_size_in_gigs
  validates_numericality_of :hd_size_in_gigs, :greater_than_or_equal_to => 0,
                            :allow_nil => true

  validates_presence_of :processor_unit_price
  validates_numericality_of :processor_unit_price, :greater_than => 0, :allow_nil => true
  
  validates_length_of :processor_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :processor_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :motherboard_unit_price
  validates_numericality_of :motherboard_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :motherboard_unit_price_desc, :in => 0..255, :allow_nil => true

  validates_inclusion_of :motherboard_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :power_supply_unit_price
  validates_numericality_of :power_supply_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true

  validates_length_of :power_supply_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :power_supply_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :case_unit_price
  validates_numericality_of :case_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :case_unit_price_desc, :in => 0..255, :allow_nil => true

  validates_inclusion_of :case_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :keyboard_unit_price
  validates_numericality_of :keyboard_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :keyboard_unit_price_desc, :in => 0..255, :allow_nil => true

  validates_inclusion_of :keyboard_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :mouse_unit_price
  validates_numericality_of :mouse_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :mouse_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :mouse_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :speakers_unit_price
  validates_numericality_of :speakers_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :speakers_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :speakers_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :monitor_unit_price
  validates_numericality_of :monitor_unit_price, :greater_than => 0,
                            :if => Proc.new { |settings| [Target::STUDENTS, Target::TEACHERS, Target::THIN_CLIENTS].include? settings.target },
                            :allow_nil => true
  validates_numericality_of :monitor_unit_price, :greater_than_or_equal_to => 0,
                            :if => Proc.new { |settings| settings.target == Target::SERVERS },
                            :allow_nil => true
                            
  validates_length_of :monitor_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :monitor_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :external_network_card_unit_price
  validates_numericality_of :external_network_card_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :external_network_card_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :external_network_card_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :external_video_card_unit_price
  validates_numericality_of :external_video_card_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :external_video_card_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :external_video_card_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :external_power_supply_unit_price
  validates_numericality_of :external_power_supply_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :external_power_supply_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :external_power_supply_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :extra1_unit_price
  validates_numericality_of :extra1_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :extra1_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :extra1_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :extra2_unit_price
  validates_numericality_of :extra2_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :extra2_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :extra2_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :extra3_unit_price
  validates_numericality_of :extra3_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :extra3_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :extra3_unit_price_curr, :in => Currency::AVAILABLE

  validates_presence_of :extra4_unit_price
  validates_numericality_of :extra4_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :extra4_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :extra4_unit_price_curr, :in => Currency::AVAILABLE
  
  after_initialize :init_attrs
  
  def self.price_cols
    WorkstationsSettings.column_names.select { |elem| 
      elem =~ /_unit_price$/
    }
  end
  
  def self.size_cols
    WorkstationsSettings.column_names.select { |elem| 
      elem =~ /_size_in_gigs$/
    }
  end

  def ram_cost
    if target != Target::THIN_CLIENTS && budget && budget.hardware_prices
      CurrencyConverter.eval(budget.hardware_prices, :ram_unit_price) * ram_size_in_gigs
    else
      0
    end
  end
  
  def hd_cost
    if budget && budget.hardware_prices
      CurrencyConverter.eval(budget.hardware_prices, :hd_unit_price) * hd_size_in_gigs
    else
      0
    end
  end

  def total_cost      
    WorkstationsSettings.price_cols.inject(0) { |sum, col|
      sum + CurrencyConverter.eval(self, col)
    } + ram_cost + hd_cost
  end
  
  protected
  
  def init_attrs
    if new_record? && target
      target_key = case target
        when Target::STUDENTS then 'students_defaults'
        when Target::TEACHERS then 'teachers_defaults'
        when Target::SERVERS then 'servers_defaults'
        when Target::THIN_CLIENTS then 'thin_clients_defaults'
      end
      
      (WorkstationsSettings.price_cols +
      WorkstationsSettings.column_names.select { |col|
        col =~ /_in_gigs$/
      }).each { |col|
        send "#{col}=", Conf.workstations_settings[target_key][col] unless send col
      }
    end
  end
  
end
