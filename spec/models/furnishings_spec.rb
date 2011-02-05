require 'spec_helper'

describe Furnishings do
  
  before do
    @furnishings = Factory :furnishings, :chairs_unit_price_desc => 'chairs_unit_price_desc'.titleize,
                           :tables_unit_price_desc => 'tables_unit_price_desc'.titleize,
                           :others_unit_price_desc => 'others_unit_price_desc'.titleize
  end
  
  it "should calculate attrs' cost" do
    @furnishings.chairs_cost.should_not be_nil
    @furnishings.tables_cost.should_not be_nil
    @furnishings.others_cost.should_not be_nil
    
    @furnishings.total_cost.should eql(@furnishings.chairs_cost + 
                                       @furnishings.tables_cost + 
                                       @furnishings.others_cost)
                                       
    @furnishings.chairs_unit_price = @furnishings.tables_unit_price = @furnishings.others_unit_price = nil
    @furnishings.chairs_cost.should be_zero
    @furnishings.tables_cost.should be_zero
    @furnishings.others_cost.should be_zero
  end
  
  #it "should have a total_cost desc" do
  #  desc = @furnishings.total_cost_desc
  #  desc.should be_an(Array)
  #  desc.should_not be_empty
  #end
  
  it "should downcase its attrs before saving" do
    @furnishings.chairs_unit_price_desc.should == 'chairs_unit_price_desc'.humanize.downcase
    @furnishings.tables_unit_price_desc.should == 'tables_unit_price_desc'.humanize.downcase
    @furnishings.others_unit_price_desc.should == 'others_unit_price_desc'.humanize.downcase
  end
  
end