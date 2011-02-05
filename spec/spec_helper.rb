# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  
  config.before(:each, :type => :helper) {
    I18n.locale = 'es-AR'
  }
end

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
                                                       Conf.software['students_standalone_defaults'].merge('target' => Software::Target::STUDENTS_STANDALONE, 
                                                                                                             'mask' => Software::Target::STUDENTS_STANDALONE_MASK,
                                                                                                             'free_soft_only' => false)
  @budget.teachers_standalone_software = Factory.build :software, 
                                                       Conf.software['teachers_standalone_defaults'].merge('target' => Software::Target::TEACHERS_STANDALONE, 
                                                                                                             'mask' => Software::Target::TEACHERS_STANDALONE_MASK,
                                                                                                             'free_soft_only' => false)
  @budget.tc_server_software = Factory.build :software, 
                                             Conf.software['tc_server_defaults'].merge('target' => Software::Target::TC_SERVER, 
                                                                                         'mask' => Software::Target::TC_SERVER_MASK,
                                                                                         'free_soft_only' => false)
  @budget.tc_software = Factory.build :software, 
                                      Conf.software['tc_defaults'].merge('target' => Software::Target::TC, 
                                                                           'mask' => Software::Target::TC_MASK,
                                                                           'free_soft_only' => false)
  
  # settings
  @budget.settings = Factory :settings, 
                             :students_standalone_workstations_enabled => true,
                             :building_improvements_cost => 123.45,
                             :electric_installation_cost => 456.78
end
