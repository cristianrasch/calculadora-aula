class Budget < ActiveRecord::Base
  
  has_one :general_settings, :dependent => :delete
  has_one :hardware_prices, :dependent => :delete
  has_one :lan_settings, :dependent => :delete
  
  has_many :workstations_settings, 
           :class_name => 'WorkstationsSettings',
           :dependent => :delete_all
  has_one :students_workstations_settings,
          :class_name => 'WorkstationsSettings',
          :conditions => ['target = ?', WorkstationsSettings::Target::STUDENTS]
  has_one :teachers_workstations_settings,
          :class_name => 'WorkstationsSettings',
          :conditions => ['target = ?', WorkstationsSettings::Target::TEACHERS]
  has_one :servers_workstations_settings,
          :class_name => 'WorkstationsSettings',
          :conditions => ['target = ?', WorkstationsSettings::Target::SERVERS]
  has_one :thin_clients_workstations_settings,
          :class_name => 'WorkstationsSettings',
          :conditions => ['target = ?', WorkstationsSettings::Target::THIN_CLIENTS]

  has_many :furnishings,
           :class_name => 'Furnishings',
           :dependent => :delete_all
  has_one :students_furnishings,
          :class_name => 'Furnishings',
          :conditions => ['target = ?', Furnishings::Target::STUDENTS]
  has_one :teachers_furnishings,
          :class_name => 'Furnishings',
          :conditions => ['target = ?', Furnishings::Target::TEACHERS]
  has_one :servers_furnishings,
          :class_name => 'Furnishings',
          :conditions => ['target = ?', Furnishings::Target::SERVERS]
          
  has_many :software,
           :class_name => 'Software',
           :dependent => :delete_all
  has_one :students_standalone_software,
          :class_name => 'Software',
          :conditions => ['target = ?', Software::Target::STUDENTS_STANDALONE]
  has_one :teachers_standalone_software,
          :class_name => 'Software',
          :conditions => ['target = ?', Software::Target::TEACHERS_STANDALONE]
  has_one :tc_server_software,
          :class_name => 'Software',
          :conditions => ['target = ?', Software::Target::TC_SERVER]
  has_one :tc_software,
          :class_name => 'Software',
          :conditions => ['target = ?', Software::Target::TC]

  has_one :settings, :dependent => :delete

  cattr_reader :per_page
  @@per_page = 5
  
  validates_presence_of :name
  validates_length_of :name, :within => 3..255, :allow_blank => true
  validates_uniqueness_of :name, :allow_blank => true
  
  validates_length_of :description, :minimum => 3, :allow_blank => true
  
  before_save :downcase_attrs
    
  private
  
  def downcase_attrs
    name.downcase! if name
    description.downcase! if description
  end
  
end
