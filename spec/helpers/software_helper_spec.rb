require 'spec_helper'

describe SoftwareHelper do
  
  before do
    @software = Factory :software
  end
  
  it "should return target's desc" do
    helper.target_desc(Software::Target::TEACHERS_STANDALONE).should_not be_empty
    helper.target_desc(Software::Target::STUDENTS_STANDALONE).should_not be_empty
    helper.target_desc(Software::Target::TC_SERVER).should_not be_empty
    helper.target_desc(Software::Target::TC).should_not be_empty
    helper.target_desc(-1).should be_empty
  end
  
  it "should return total_cost desc" do
    desc = helper.soft_total_cost_desc @software
    desc.should be_an(Array)
    desc.should_not be_empty
  end
  
  it "should return soft's reference values" do
    ref_val = helper.soft_reference_values @software
    ref_val.should_not be_empty
    ref_val.each do |arr|
      arr.should have(2).items
    end
  end
  
end