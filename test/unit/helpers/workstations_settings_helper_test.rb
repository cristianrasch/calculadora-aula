require 'test_helper'

class WorkstationsSettingsHelperTest < ActionView::TestCase

  test "target_desc" do
    assert ! target_desc(WorkstationsSettings::Target::STUDENTS).empty?
    assert ! target_desc(WorkstationsSettings::Target::TEACHERS).empty?
    assert ! target_desc(WorkstationsSettings::Target::SERVERS).empty?
    assert ! target_desc(WorkstationsSettings::Target::THIN_CLIENTS).empty?
    assert target_desc(-1).empty?
  end
  
  test "ws_total_cost_desc" do
    desc = ws_total_cost_desc @ws_settings
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "ws_reference_values" do
    ref_val = ws_reference_values @ws_settings
    assert ! ref_val.length.zero?
    ref_val.each do |arr|
      assert_equal 2, arr.length
    end
  end
  
  def setup
    @ws_settings = Factory :workstations_settings
  end

end
