require 'spec_helper'

describe GeneralSettings do
  
  before do
    @general_settings = Factory :general_settings
  end
  
  it "should have a students_workstations_count desc" do
    desc = @general_settings.students_workstations_count_desc
    desc.should be_an(Array)
    desc.should_not be_empty
  end
  
  it "should have a servers_count desc" do
    desc = @general_settings.servers_count_desc
    desc.should be_an(Array)
    desc.should_not be_empty
  end
  
  it "should return proper students_workstations and servers count" do
    @general_settings.students_workstations_count.should_not be_zero
    @general_settings.servers_count.should_not be_zero
    
    @general_settings.students_count = @general_settings.clients_per_server = nil
    
    @general_settings.students_workstations_count.should be_zero
    @general_settings.servers_count.should be_zero
  end
  
end