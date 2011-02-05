class Software < ActiveRecord::Base

  include ARHelper if table_exists?

  OS_MASK = 1
  OFFICE_SUITE_MASK = 2
  CLASS_MONITORING_N_CTRL_MASK = 4
  TC_SERVER_MASK = 8
  WEB_SERVER_MASK = 16
  PROXY_SERVER_MASK = 32
  FILE_N_PRINTING_SERVER_MASK = 64
  TC_LICENCE_MASK = 128
  SPECIALIZED_APPS_MASK = 256
  OTHERS_MASK = 512
  
  class Target
    STUDENTS_STANDALONE = 1
    TEACHERS_STANDALONE = 2
    TC_SERVER = 3
    TC = 4
    
    STUDENTS_STANDALONE_MASK = OS_MASK+OFFICE_SUITE_MASK+CLASS_MONITORING_N_CTRL_MASK
    TEACHERS_STANDALONE_MASK = OS_MASK+OFFICE_SUITE_MASK+CLASS_MONITORING_N_CTRL_MASK
    TC_SERVER_MASK = OS_MASK+OFFICE_SUITE_MASK+TC_SERVER_MASK+WEB_SERVER_MASK+
                     PROXY_SERVER_MASK+FILE_N_PRINTING_SERVER_MASK
    TC_MASK = OS_MASK+OFFICE_SUITE_MASK+TC_LICENCE_MASK+SPECIALIZED_APPS_MASK+
              OTHERS_MASK
              
    def self.target_mask target
      case target
        when STUDENTS_STANDALONE then STUDENTS_STANDALONE_MASK
        when TEACHERS_STANDALONE then TEACHERS_STANDALONE_MASK
        when TC_SERVER then TC_SERVER_MASK
        when TC then TC_MASK
      end
    end
  end
  
  belongs_to :budget

  validates_presence_of :target
  validates_inclusion_of :target, :in => Target::STUDENTS_STANDALONE..Target::TC,
                         :allow_nil => true
  validates_uniqueness_of :target, :scope => :budget_id, :allow_nil => true
  
  validates_presence_of :mask
  validates_numericality_of :mask, :allow_nil => true
  
  validates_presence_of :os_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'os_unit_price' }
  validates_numericality_of :os_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :os_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :os_unit_price_curr, :in => Currency::AVAILABLE
  
  validates_presence_of :office_suite_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'office_suite_unit_price' }
  validates_numericality_of :office_suite_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :office_suite_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :office_suite_unit_price_curr, :in => Currency::AVAILABLE
                            
  validates_presence_of :class_mon_n_ctrl_apps_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'monitoring_n_ctrl_apps' }
  validates_numericality_of :class_mon_n_ctrl_apps_unit_price, 
                            :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :class_mon_n_ctrl_apps_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :class_mon_n_ctrl_apps_unit_price_curr, :in => Currency::AVAILABLE
                          
  validates_presence_of :tc_srv_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'tc_srv_unit_price' }
  validates_numericality_of :tc_srv_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :tc_srv_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :tc_srv_unit_price_curr, :in => Currency::AVAILABLE
                            
  validates_presence_of :web_srv_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'web_srv_unit_price' }
  validates_numericality_of :web_srv_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :web_srv_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :web_srv_unit_price_curr, :in => Currency::AVAILABLE
                            
  validates_presence_of :proxy_srv_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'proxy_srv_unit_price' }
  validates_numericality_of :proxy_srv_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :proxy_srv_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :proxy_srv_unit_price_curr, :in => Currency::AVAILABLE
                            
  validates_presence_of :file_n_print_srv_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'file_n_print_srv_unit_price' }
  validates_numericality_of :file_n_print_srv_unit_price, 
                            :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :file_n_print_srv_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :file_n_print_srv_unit_price_curr, :in => Currency::AVAILABLE
                            
  validates_presence_of :tc_lic_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'tc_lic_unit_price' }
  validates_numericality_of :tc_lic_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :tc_lic_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :tc_lic_unit_price_curr, :in => Currency::AVAILABLE
                            
  validates_presence_of :spec_apps_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'spec_apps_unit_price' }
  validates_numericality_of :spec_apps_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :spec_apps_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :spec_apps_unit_price_curr, :in => Currency::AVAILABLE
                            
  validates_presence_of :others_unit_price, :if => Proc.new { |sw| sw.price_cols.include? 'others_unit_price' }
  validates_numericality_of :others_unit_price, :greater_than_or_equal_to => 0,
                            :allow_nil => true
                            
  validates_length_of :others_unit_price_desc, :in => 0..255, :allow_nil => true
  
  validates_inclusion_of :others_unit_price_curr, :in => Currency::AVAILABLE

  validates_inclusion_of :free_soft_only, :in => [true, false]
         
  after_initialize :init_attrs
         
  def self.price_cols
    Software.column_names.select do |col| 
      col =~ /_unit_price$/
    end
  end
  
  def price_cols
    @cols ||= []
    Software.price_cols.each_with_index { |col, idx|
      @cols << col if (mask & (2**idx)) > 0
    } if @cols.empty?
    @cols
  end
  
  def total_cost
    if free_soft_only
      0
    else
      price_cols.inject(0) { |sum, col|
        sum += CurrencyConverter.eval self, col
      }
    end
  end
  
  protected
  
  def init_attrs
    if new_record? && target
      self.mask = Target.target_mask target unless mask
      
      target_key = case target
                     when Target::STUDENTS_STANDALONE then 'students_standalone_defaults'
                     when Target::TEACHERS_STANDALONE then 'teachers_standalone_defaults'
                     when Target::TC_SERVER then 'tc_server_defaults'
                     when Target::TC then 'tc_defaults'
                   end
      
      price_cols.each { |col|
        send "#{col}=", Conf.software[target_key][col] unless send col
      }
    end
  end
  
end
