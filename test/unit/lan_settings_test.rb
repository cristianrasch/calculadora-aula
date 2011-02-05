require 'test_helper'

class LanSettingsTest < ActiveSupport::TestCase
  
  test "workstations_and_servers_count" do
    assert_not_nil @lan_settings.workstations_and_servers_count
    assert_not_equal 0, @lan_settings.workstations_and_servers_count
  end
  
  test "switches_count" do
    assert_not_equal 0,  @lan_settings.switches_count
  end
  
  test "network_cable_meters_count" do
    assert_not_equal 0,  @lan_settings.network_cable_meters_count
  end
  
  test "switches_cost" do
    assert @lan_settings.switches_cost > 0
  end
  
  test "network_cable_cost" do
    assert @lan_settings.network_cable_cost > 0
  end
  
  test "rj45_connectors_cost" do
    assert @lan_settings.rj45_connectors_cost > 0
  end
  
  test "total_cost" do
    assert  @lan_settings.total_cost > 0
  end
  
  test "downcase_attrs" do
    lan_settings = Factory :lan_settings, 
                           :ports_per_switch_desc => 'ports_per_switch_desc'.titleize,
                           :medium_distance_bt_pcs_switch_desc => 'medium_distance_bt_pcs_switch_desc'.titleize,
                           :installation_materials_and_wiring_cost_desc => 'installation_materials_and_wiring_cost_desc'.titleize
    assert_equal 'ports_per_switch_desc'.humanize.downcase, lan_settings.ports_per_switch_desc
    assert_equal 'medium_distance_bt_pcs_switch_desc'.humanize.downcase, lan_settings.medium_distance_bt_pcs_switch_desc
    assert_equal 'installation_materials_and_wiring_cost_desc'.humanize.downcase, 
                  lan_settings.installation_materials_and_wiring_cost_desc
  end

  protected
  
  def setup
    @budget = Factory :budget
    @budget.general_settings = Factory.build :general_settings
    @budget.hardware_prices = Factory.build :hardware_prices
    @lan_settings = @budget.lan_settings = Factory.build(:lan_settings)
  end

end
