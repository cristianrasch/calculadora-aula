require 'spec_helper'

describe HardwarePricesHelper do
  
  it "should return hp's reference values" do
    ref_val = helper.hp_reference_values Factory(:hardware_prices)
    ref_val.should_not be_empty
    ref_val.each do |arr|
      arr.should have(2).items
    end
  end
  
end