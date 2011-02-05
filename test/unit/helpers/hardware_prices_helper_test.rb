require 'test_helper'

class HardwarePricesHelperTest < ActionView::TestCase
  
  test "hp_reference_values" do
    ref_val = hp_reference_values Factory(:hardware_prices)
    assert ! ref_val.length.zero?
    ref_val.each do |arr|
      assert_equal 2, arr.length
    end
  end
  
end
