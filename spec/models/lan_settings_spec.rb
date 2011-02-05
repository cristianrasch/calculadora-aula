require 'spec_helper'

describe LanSettings do
  
  before do
    @budget = Factory :budget
    @budget.general_settings = Factory.build :general_settings
    @budget.hardware_prices = Factory.build :hardware_prices
    @lan_settings = @budget.lan_settings = Factory.build(:lan_settings)
  end
  
  it "should have a workstations_and_servers count" do
    @lan_settings.workstations_and_servers_count.should_not be_nil
    @lan_settings.workstations_and_servers_count.should_not == 0
  end
  
  it "should have a switches count" do
    @lan_settings.switches_count.should_not == 0
  end
  
  it "should have a network_cable_meters count" do
    @lan_settings.network_cable_meters_count.should_not == 0
  end
  
  it "should have a switches cost" do
    @lan_settings.switches_cost.should > 0
  end
  
  it "should have a network_cable cost" do
    @lan_settings.network_cable_cost.should > 0
  end
  
  it "should have a rj45_connectors cost" do
    @lan_settings.rj45_connectors_cost.should > 0
  end
  
  it "should have a total_cost" do
    @lan_settings.total_cost.should > 0
  end
  
  it "should downcase its attrs before saving" do
    lan_settings = Factory :lan_settings, 
                           :ports_per_switch_desc => 'ports_per_switch_desc'.titleize,
                           :medium_distance_bt_pcs_switch_desc => 'medium_distance_bt_pcs_switch_desc'.titleize,
                           :installation_materials_and_wiring_cost_desc => 'installation_materials_and_wiring_cost_desc'.titleize
    
    lan_settings.ports_per_switch_desc.should == 'ports_per_switch_desc'.humanize.downcase
    lan_settings.medium_distance_bt_pcs_switch_desc.should == 'medium_distance_bt_pcs_switch_desc'.humanize.downcase
    lan_settings.installation_materials_and_wiring_cost_desc.should == 'installation_materials_and_wiring_cost_desc'.humanize.downcase
  end
  
end