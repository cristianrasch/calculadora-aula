require 'test_helper'

class LanSettingsHelperTest < ActionView::TestCase
  
  test "ls_workstations_and_servers_count_desc" do
    desc = ls_workstations_and_servers_count_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "ls_switches_count_desc" do
    desc = ls_switches_count_desc @lan_settings
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "ls_network_cable_meters_count_desc" do
    desc = ls_network_cable_meters_count_desc @lan_settings
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "ls_switches_cost_desc" do
    desc = ls_switches_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "ls_network_cable_cost_desc" do
    desc = ls_network_cable_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "ls_rj45_connectors_cost_desc" do
    desc = ls_rj45_connectors_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "ls_total_cost_desc" do
    desc = ls_total_cost_desc @lan_settings
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "ls_reference_values" do
    ref_val = ls_reference_values @lan_settings
    assert ! ref_val.length.zero?
    ref_val.each do |arr|
      assert_equal 2, arr.length
    end
  end
  
  protected
  
  def setup
    @budget = Factory :budget
    @budget.general_settings = Factory.build :general_settings
    @budget.hardware_prices = Factory.build :hardware_prices
    @lan_settings = @budget.lan_settings = Factory.build(:lan_settings)
  end
  
end
