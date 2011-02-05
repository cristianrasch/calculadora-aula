class GeneralSettings < ActiveRecord::Base
  
  belongs_to :budget
  
  validates_presence_of :students_count
  validates_numericality_of :students_count, :greater_than => 0, :allow_nil => true
  
  validates_presence_of :students_per_workstation
  validates_numericality_of :students_per_workstation, :greater_than_or_equal_to => 1,
                            :less_than_or_equal_to => 5, :allow_nil => true
                            
  validates_presence_of :teachers_count
  validates_numericality_of :teachers_count, :greater_than_or_equal_to => 1,
                            :less_than_or_equal_to => 3, :allow_nil => true
  
  validates_presence_of :clients_per_server
  validates_numericality_of :clients_per_server, :greater_than_or_equal_to => 1,
                            :less_than_or_equal_to => 30, :allow_nil => true

  after_initialize :init_attrs

  def students_workstations_count
    if students_count && students_per_workstation
      (students_count/students_per_workstation.to_f).ceil
    else
      0
    end
  end
  
  def students_workstations_count_desc
    ["#{GeneralSettings.human_attribute_name('students_count')} (#{students_count})",
    "#{GeneralSettings.human_attribute_name('students_per_workstation')} (#{students_per_workstation})"]
  end
  
  def servers_count
    if students_workstations_count && clients_per_server
      (students_workstations_count/clients_per_server.to_f).ceil
    else
      0
    end
  end
  
  def servers_count_desc
    ["#{GeneralSettings.human_attribute_name('students_workstations_count')} (#{students_workstations_count})",
    "#{GeneralSettings.human_attribute_name('clients_per_server')} (#{clients_per_server})"]
  end
  
  protected
  
  def init_attrs
    if new_record?
      self.students_count = Conf.general_settings['students_count'] unless students_count
      self.students_per_workstation = Conf.general_settings['students_per_workstation'] unless students_per_workstation
      self.teachers_count = Conf.general_settings['teachers_count'] unless teachers_count
      self.clients_per_server = Conf.general_settings['clients_per_server'] unless clients_per_server
    end
  end
  
end
