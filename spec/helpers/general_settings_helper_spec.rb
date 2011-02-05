require 'spec_helper'

describe GeneralSettingsHelper do
  
  it "should return gs' reference values" do
    ref_val = helper.gs_reference_values Factory(:general_settings)
    ref_val.should_not be_empty
    ref_val.each do |arr|
      arr.should have(2).items
    end
  end
  
end