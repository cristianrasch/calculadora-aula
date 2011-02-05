require 'test_helper'

class FurnishingsHelperTest < ActionView::TestCase

  test "target_desc" do
    assert ! target_desc(Furnishings::Target::STUDENTS).empty?
    assert ! target_desc(Furnishings::Target::TEACHERS).empty?
    assert ! target_desc(Furnishings::Target::SERVERS).empty?
    assert target_desc(-1).empty?
  end
  
  test "f_total_cost_desc" do
    desc = f_total_cost_desc Factory(:furnishings)
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "f_reference_values" do
    ref_val = f_reference_values Factory(:furnishings)
    assert ! ref_val.length.zero?
    ref_val.each do |arr|
      assert_equal 2, arr.length
    end
  end

end
