require 'test_helper'

class GeneralSettingsHelperTest < ActionView::TestCase
  
  test "gs_reference_values" do
    ref_val = gs_reference_values Factory(:general_settings)
    assert ! ref_val.length.zero?
    ref_val.each do |arr|
      assert_equal 2, arr.length
    end
  end
  
end
