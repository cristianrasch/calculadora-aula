require 'spec_helper'

describe FurnishingsHelper do
  
  it "should return a target desc" do
    helper.target_desc(Furnishings::Target::STUDENTS).should_not be_empty
    helper.target_desc(Furnishings::Target::TEACHERS).should_not be_empty
    helper.target_desc(Furnishings::Target::SERVERS).should_not be_empty
    helper.target_desc(-1).should be_empty
  end
  
  it "should return furnishings' total cost desc" do
    desc = helper.f_total_cost_desc Factory(:furnishings)
    desc.should be_an(Array)
    desc.should_not be_empty
  end
  
  it "should return furnishings' reference values" do
    ref_val = helper.f_reference_values Factory(:furnishings)
    ref_val.should_not be_empty
    ref_val.each do |arr|
      arr.should have(2).items
    end
  end
  
end