require 'spec_helper'

describe SettingsHelper do
  
  before do
    generate_budget
    @settings = @budget.settings = Factory.build(:settings)
  end
  
  it "should return settings' descriptions" do
    %w{s_students_standalone_workstations_cost_desc
      s_teachers_standalone_workstations_cost_desc
      s_thin_clients_cost_desc
      s_thin_clients_server_cost_desc
      s_ups_cost_desc
      s_printers_cost_desc
      s_scanners_cost_desc
      s_students_furnishings_cost_desc
      s_teachers_furnishings_cost_desc
      s_servers_furnishings_cost_desc
      s_students_software_cost_desc
      s_teachers_software_cost_desc
      s_tc_server_software_cost_desc
      s_tc_software_cost_desc}.each do |method|
        desc = helper.send method, @budget
        desc.should be_an(Array)
        desc.should_not be_empty
      end
  end
  
  it "should return settings' total_cost desc" do
    arr = helper.s_total_cost_desc @budget
    arr.should_not be_empty
    arr.each do |elem|
      elem.should_not be_blank
    end
  end
  
  it "should return settings' reference values" do
    ref_val = helper.s_reference_values @settings
    ref_val.should_not be_empty
    ref_val.each do |arr|
      arr.should have(2).items
    end
  end
  
end