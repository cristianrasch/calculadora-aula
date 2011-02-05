require 'spec_helper'

describe Settings do
  
  before do
    generate_budget
    @settings = @budget.settings
  end
  
  it "should have a students_standalone_workstations cost" do
    @settings.students_standalone_workstations_cost.should > 0
  end
  
  it "should have a teachers_standalone_workstations cost" do
    @settings.teachers_standalone_workstations_cost.should > 0
  end
  
  it "should have a thin_clients cost" do
    @settings.thin_clients_cost.should > 0
  end
  
  it "should have a thin_clients_server cost" do
    @settings.thin_clients_server_cost.should > 0
  end
  
  it "should have a lan cost" do
    @settings.lan_cost.should > 0
  end
  
  it "should have a ups cost" do
    @settings.ups_cost.should > 0
  end
  
  it "should have a printers cost" do
    @settings.printers_cost.should > 0
  end
  
  it "should have a scanners cost" do
    @settings.scanners_cost.should > 0
  end
  
  it "should have a students_furnishings cost" do
    @settings.students_furnishings_cost.should > 0
  end
  
  it "should have a teachers_furnishings cost" do
    @settings.teachers_furnishings_cost.should > 0
  end
  
  it "should have a servers_furnishings cost" do
    @settings.servers_furnishings_cost.should > 0
  end
  
  it "should have a students_software cost" do
    @settings.students_software_cost.should > 0
  end
  
  it "should have a teachers_software cost" do
    @settings.teachers_software_cost.should > 0
  end
  
  it "should have a thin_clients_server_software cost" do
    assert @settings.tc_server_software_cost > 0
  end
  
  it "should have a thin_clients_software" do
    @settings.tc_software_cost.should > 0
  end
  
  it "should downcase its attrs before saving" do
    settings = Factory :settings,
                       :building_improvements_cost_desc => 'building_improvements_cost_desc'.titleize,
                       :electric_installation_cost_desc => 'electric_installation_cost_desc'.titleize
    
    settings.building_improvements_cost_desc.should == 'building_improvements_cost_desc'.humanize.downcase
    settings.electric_installation_cost_desc.should == 'electric_installation_cost_desc'.humanize.downcase
  end
  
end