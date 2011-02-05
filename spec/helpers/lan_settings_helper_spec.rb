require 'spec_helper'

describe LanSettingsHelper do

  before do
    @budget = Factory :budget
    @budget.general_settings = Factory.build :general_settings
    @budget.hardware_prices = Factory.build :hardware_prices
    @lan_settings = @budget.lan_settings = Factory.build(:lan_settings)
  end
  
  it "should return ls' descriptions" do
    %w{ls_workstations_and_servers_count_desc 
      ls_workstations_and_servers_count_desc
      ls_switches_cost_desc
      ls_network_cable_cost_desc
      ls_rj45_connectors_cost_desc}.each do |method|
        desc = helper.send method, @budget
        desc.should be_an(Array)
        desc.should_not be_empty
      end
    
    %w{ls_switches_count_desc
      ls_network_cable_meters_count_desc
      ls_total_cost_desc}.each do |method|
        desc = helper.send method, @lan_settings
        desc.should be_an(Array)
        desc.should_not be_empty
      end
  end
  
  it "should return ls' reference values" do
    ref_val = helper.ls_reference_values @lan_settings
    ref_val.should_not be_empty
    ref_val.each do |arr|
      arr.should have(2).items
    end
  end
  
end