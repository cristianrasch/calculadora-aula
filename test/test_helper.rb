ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  include ApplicationHelper
  
  def generate_budget
    # budgets
    @budget = Factory :budget
    
    # general settings
    @budget.general_settings = Factory.build(:general_settings)
    
    # hardware prices
    @budget.hardware_prices = Factory.build(:hardware_prices)
    
    # lan settings
    @budget.lan_settings = Factory.build(:lan_settings)
    
    # workstations settings
    @budget.create_students_workstations_settings Conf.workstations_settings['students_defaults'].merge(:target => WorkstationsSettings::Target::STUDENTS)
    @budget.create_teachers_workstations_settings Conf.workstations_settings['teachers_defaults'].merge(:target => WorkstationsSettings::Target::TEACHERS)
    @budget.create_servers_workstations_settings Conf.workstations_settings['servers_defaults'].merge(:target => WorkstationsSettings::Target::SERVERS)
    @budget.create_thin_clients_workstations_settings Conf.workstations_settings['thin_clients_defaults'].merge(:target => WorkstationsSettings::Target::THIN_CLIENTS)
    
    # furnishings
    @budget.students_furnishings = Factory.build :furnishings, {:target => Furnishings::Target::STUDENTS}.merge(Conf.furnishings['students_defaults'])
    @budget.teachers_furnishings = Factory.build :furnishings, {:target => Furnishings::Target::TEACHERS}.merge(Conf.furnishings['teachers_defaults'])
    @budget.servers_furnishings = Factory.build :furnishings, {:target => Furnishings::Target::SERVERS}.merge(Conf.furnishings['servers_defaults'])
    
    # software
    @budget.students_standalone_software = Factory.build :software, 
                                                         Conf.software['students_standalone_defaults'].merge(:target => Software::Target::STUDENTS_STANDALONE, 
                                                                                                                 :mask => Software::Target::STUDENTS_STANDALONE_MASK,
                                                                                                                 :free_soft_only => false)
    @budget.teachers_standalone_software = Factory.build :software, 
                                                         Conf.software['teachers_standalone_defaults'].merge(:target => Software::Target::TEACHERS_STANDALONE, 
                                                                                                                 :mask => Software::Target::TEACHERS_STANDALONE_MASK,
                                                                                                                 :free_soft_only => false)
    @budget.tc_server_software = Factory.build :software, 
                                               Conf.software['tc_server_defaults'].merge(:target => Software::Target::TC_SERVER, 
                                                                                             :mask => Software::Target::TC_SERVER_MASK,
                                                                                             :free_soft_only => false)
    @budget.tc_software = Factory.build :software, 
                                        Conf.software['tc_defaults'].merge(:target => Software::Target::TC, 
                                                                               :mask => Software::Target::TC_MASK,
                                                                               :free_soft_only => false)
    
    # settings
    @budget.settings = Factory :settings, 
                               :students_standalone_workstations_enabled => true,
                               :building_improvements_cost => 123.45,
                               :electric_installation_cost => 456.78
  end
end
