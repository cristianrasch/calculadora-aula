require 'test_helper'

class SoftwareHelperTest < ActionView::TestCase
  
  test "target_desc" do
    assert ! target_desc(Software::Target::TEACHERS_STANDALONE).empty?
    assert ! target_desc(Software::Target::STUDENTS_STANDALONE).empty?
    assert ! target_desc(Software::Target::TC_SERVER).empty?
    assert ! target_desc(Software::Target::TC).empty?
    assert target_desc(-1).empty?
  end
  
  test "total_cost_desc" do
    desc = soft_total_cost_desc @software
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "soft_reference_values" do
    ref_val = soft_reference_values @software
    assert ! ref_val.length.zero?
    ref_val.each do |arr|
      assert_equal 2, arr.length
    end
  end
  
  protected
  
  def setup
    @software = Factory(:software)
  end
  
end
