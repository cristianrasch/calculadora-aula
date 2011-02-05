require 'test_helper'

class SettingsHelperTest < ActionView::TestCase
  
  test "s_students_standalone_workstations_cost_desc" do
    desc = s_students_standalone_workstations_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_teachers_standalone_workstations_cost_desc" do
    desc = s_teachers_standalone_workstations_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_thin_clients_cost_desc" do
    desc = s_thin_clients_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_thin_clients_server_cost_desc" do
    desc = s_thin_clients_server_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_ups_cost_desc" do
    desc = s_ups_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_printers_cost_desc" do
    desc = s_printers_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_scanners_cost_desc" do
    desc = s_scanners_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_students_furnishings_cost_desc" do
    desc = s_students_furnishings_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_teachers_furnishings_cost_desc" do
    desc = s_teachers_furnishings_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_servers_furnishings_cost_desc" do
    desc = s_servers_furnishings_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_students_software_cost_desc" do
    desc = s_students_software_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_teachers_software_cost_desc" do
    desc = s_teachers_software_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_tc_server_software_cost_desc" do
    desc = s_tc_server_software_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_tc_software_cost_desc" do
    desc = s_tc_software_cost_desc @budget
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "s_total_cost_desc" do
    arr = s_total_cost_desc @budget
    assert ! arr.empty?
    arr.each do |elem|
      assert ! elem.blank?
    end
  end
  
  test "s_reference_values" do
    ref_val = s_reference_values @settings
    assert ! ref_val.length.zero?
    ref_val.each do |arr|
      assert_equal 2, arr.length
    end
  end
  
  protected
  
  def setup
    generate_budget
    @settings = @budget.settings = Factory.build(:settings)
  end
  
end