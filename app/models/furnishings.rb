class Furnishings < ActiveRecord::Base

  include ARHelper if table_exists?

  class Target
    STUDENTS = 1
    TEACHERS = 2
    SERVERS = 3
  end

  belongs_to :budget

  validates_presence_of :target
  validates_inclusion_of :target, :in => Target::STUDENTS..Target::SERVERS,
                         :allow_nil => true
  validates_uniqueness_of :target, :scope => :budget_id, :allow_nil => true

  validates_presence_of :chairs_unit_price
  validates_numericality_of :chairs_unit_price, :greater_than => 0,
                            :if => Proc.new { |furnishings|
                                              [Target::STUDENTS, Target::TEACHERS].include? furnishings.target
                                            },
                            :allow_nil => true
  validates_numericality_of :chairs_unit_price, :greater_than_or_equal_to => 0,
                            :if => Proc.new { |furnishings| furnishings.target == Target::SERVERS },
                            :allow_nil => true
                            
  validates_length_of :chairs_unit_price_desc, :in => 0..255, :allow_nil => true

  validates_presence_of :chairs_per_workstation
  validates_numericality_of :chairs_per_workstation, :greater_than => 0,
                            :allow_nil => true

  validates_presence_of :tables_unit_price
  validates_numericality_of :tables_unit_price, :greater_than => 0, :allow_nil => true
  
  validates_length_of :tables_unit_price_desc, :in => 0..255, :allow_nil => true

  validates_presence_of :tables_per_workstation
  validates_numericality_of :tables_per_workstation, :greater_than => 0,
                            :allow_nil => true

  validates_presence_of :others_unit_price
  validates_numericality_of :others_unit_price, :greater_than_or_equal_to => 0, :allow_nil => true
  
  validates_length_of :others_unit_price_desc, :in => 0..255, :allow_nil => true

  validates_presence_of :others_per_workstation
  validates_numericality_of :others_per_workstation, :greater_than_or_equal_to => 0,
                            :allow_nil => true

  after_initialize :init_attrs
                            
  def self.cols
    Furnishings.column_names.map { |col| 
      $` if col =~ /_unit_price$/
    }.compact
  end
                            
  def chairs_cost
    if chairs_per_workstation && chairs_unit_price
      chairs_per_workstation * chairs_unit_price
    else
      0
    end
  end

  def tables_cost
    if tables_per_workstation && tables_unit_price
      tables_per_workstation * tables_unit_price
    else
      0
    end
  end

  def others_cost
    if others_per_workstation && others_unit_price
      others_per_workstation * others_unit_price
    else
      0
    end
  end

  def total_cost
    chairs_cost + tables_cost + others_cost
  end
  
  protected
  
  def init_attrs
    if new_record?
      if target
        target_key = case self.target
                       when Target::STUDENTS then 'students_defaults'
                       when Target::TEACHERS then 'teachers_defaults'
                       when Target::SERVERS then 'servers_defaults'
                     end
        
        self.chairs_unit_price = Conf.furnishings[target_key]['chairs_unit_price'] unless chairs_unit_price
        self.tables_unit_price = Conf.furnishings[target_key]['tables_unit_price'] unless tables_unit_price
        self.others_unit_price = Conf.furnishings[target_key]['others_unit_price'] unless others_unit_price
      end

      self.chairs_per_workstation = target == Target::STUDENTS ? Conf.general_settings['students_per_workstation'] : 1 unless chairs_per_workstation
      self.tables_per_workstation = Conf.furnishings['tables_per_workstation'] unless tables_per_workstation
      self.others_per_workstation = Conf.furnishings['others_per_workstation'] unless others_per_workstation
    end
  end
  
end
