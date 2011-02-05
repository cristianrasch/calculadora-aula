require 'test_helper'

class SettingsTest < ActiveSupport::TestCase

  test "students_standalone_workstations_cost" do
    assert @settings.students_standalone_workstations_cost > 0
  end
  
  test "teachers_standalone_workstations_cost" do
    assert @settings.teachers_standalone_workstations_cost > 0
  end
  
  test "thin_clients_cost" do
    assert @settings.thin_clients_cost > 0
  end
  
  test "thin_clients_server_cost" do
    assert @settings.thin_clients_server_cost > 0
  end
  
  test "lan_cost" do
    assert @settings.lan_cost > 0
  end
  
  test "ups_cost" do
    assert @settings.ups_cost > 0
  end
  
  test "printers_cost" do
    assert @settings.printers_cost > 0
  end
  
  test "scanners_cost" do
    assert @settings.scanners_cost > 0
  end
  
  test "students_furnishings_cost" do
    assert @settings.students_furnishings_cost > 0
  end
  
  test "teachers_furnishings_cost" do
    assert @settings.teachers_furnishings_cost > 0
  end
  
  test "servers_furnishings_cost" do
    assert @settings.servers_furnishings_cost > 0
  end
  
  test "students_software_cost" do
    assert @settings.students_software_cost > 0
  end
  
  test "teachers_software_cost" do
    assert @settings.teachers_software_cost > 0
  end
  
  test "thin_clients_server_software_cost" do
    assert @settings.tc_server_software_cost > 0
  end
  
  test "thin_clients_software_cost" do
    assert @settings.tc_software_cost > 0
  end
  
  #test "new object's associations" do
  #  budget = Factory :budget, :settings => Factory.build(:settings)
  #  settings = budget.settings
  #  assert_equal 0, settings.students_standalone_workstations_cost
  #  assert_equal 0, settings.teachers_standalone_workstations_cost
  #  assert_equal 0, settings.thin_clients_cost
  #  assert_equal 0, settings.thin_clients_server_cost
  #  assert_equal 0, settings.ups_cost
  #  assert_equal 0, settings.printers_cost
  #  assert_equal 0, settings.scanners_cost
  #  assert_equal 0, settings.students_furnishings_cost
  #  assert_equal 0, settings.teachers_furnishings_cost
  #  assert_equal 0, settings.servers_furnishings_cost
  #  assert_equal 0, settings.students_software_cost
  #  assert_equal 0, settings.teachers_software_cost
  #  assert_equal 0, settings.tc_server_software_cost
  #  assert_equal 0, settings.tc_software_cost
  #  assert_equal false, settings.prop_students_soft_enabled?
  #  assert_equal false, settings.prop_teachers_soft_enabled?
  #  assert_equal false, settings.prop_tc_server_soft_enabled?
  #  assert_equal false, settings.prop_tc_soft_enabled?
  #  assert_equal 0, settings.total_cost
  #end
  
  test "downcase_attrs" do
    settings = Factory :settings,
                       :building_improvements_cost_desc => 'building_improvements_cost_desc'.titleize,
                       :electric_installation_cost_desc => 'electric_installation_cost_desc'.titleize
    
    assert_equal 'building_improvements_cost_desc'.humanize.downcase, settings.building_improvements_cost_desc
    assert_equal 'electric_installation_cost_desc'.humanize.downcase, settings.electric_installation_cost_desc
  end

  protected
  
  def setup
    generate_budget
    @settings = @budget.settings
  end

end
