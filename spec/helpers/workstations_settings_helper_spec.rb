require 'spec_helper'

describe WorkstationsSettingsHelper do
  
  before do
    budget = Factory :budget
    budget.hardware_prices = Factory.build :hardware_prices, 
                                           :ram_unit_price_curr => Currency::USD
    budget.workstations_settings << Factory.build(:workstations_settings)
    @ws_settings = budget.workstations_settings.first
  end
  
  it "should return target's desc" do
    helper.target_desc(WorkstationsSettings::Target::STUDENTS).should_not be_empty
    helper.target_desc(WorkstationsSettings::Target::TEACHERS).should_not be_empty
    helper.target_desc(WorkstationsSettings::Target::SERVERS).should_not be_empty
    helper.target_desc(WorkstationsSettings::Target::THIN_CLIENTS).should_not be_empty
    assert helper.target_desc(-1).should be_empty
  end
  
  it "should return ws' total_cost desc" do
    desc = helper.ws_total_cost_desc @ws_settings
    desc.should be_an(Array)
    desc.should_not be_empty
  end
  
  it "should return ws' reference values" do
    ref_val = helper.ws_reference_values @ws_settings
    ref_val.should_not be_empty
    ref_val.each do |arr|
      arr.should have(2).items
    end
  end
  
end