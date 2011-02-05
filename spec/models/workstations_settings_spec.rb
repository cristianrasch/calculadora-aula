require 'spec_helper'

describe WorkstationsSettings do
  
  before do
    @budget = Factory :budget
    @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
  end
  
  it "should have its *_cost attrs" do
    workstations_settings = @budget.build_students_workstations_settings Factory.attributes_for(:workstations_settings)

    workstations_settings.ram_cost.should_not be_nil
    workstations_settings.hd_cost.should_not be_nil

    total_cost = workstations_settings.ram_cost + workstations_settings.hd_cost
    total_cost += WorkstationsSettings.column_names.select {|col|
                    /\w+_unit_price\z/.match col
                  }.inject(0) { |sum, col_price|
                     sum += workstations_settings.send(col_price)
                  }
    workstations_settings.total_cost.should == total_cost
  end
  
  it "should be properly initialized" do
    teachers_workstations_settings = WorkstationsSettings.new :target => WorkstationsSettings::Target::TEACHERS
    teachers_workstations_settings.ram_size_in_gigs.should == 2
    
    servers_workstations_settings = WorkstationsSettings.new :target => WorkstationsSettings::Target::SERVERS
    servers_workstations_settings.ram_size_in_gigs.should == 5
    
    thin_clients_workstations_settings = WorkstationsSettings.new :target => WorkstationsSettings::Target::THIN_CLIENTS
    thin_clients_workstations_settings.ram_size_in_gigs.should == 1
  end
  
  it "should downcase its attrs before saving" do
    ws_settings = Factory :workstations_settings, :processor_unit_price_desc => 'processor_unit_price_desc'.titleize,
                          :motherboard_unit_price_desc => 'motherboard_unit_price_desc'.titleize,
                          :power_supply_unit_price_desc => 'power_supply_unit_price_desc'.titleize,
                          :case_unit_price_desc => 'case_unit_price_desc'.titleize,
                          :keyboard_unit_price_desc => 'keyboard_unit_price_desc'.titleize,
                          :mouse_unit_price_desc => 'mouse_unit_price_desc'.titleize,
                          :speakers_unit_price_desc => 'speakers_unit_price_desc'.titleize,
                          :monitor_unit_price_desc => 'monitor_unit_price_desc'.titleize,
                          :external_network_card_unit_price_desc => 'external_network_card_unit_price_desc'.titleize,
                          :external_video_card_unit_price_desc => 'external_video_card_unit_price_desc'.titleize,
                          :external_power_supply_unit_price_desc => 'external_power_supply_unit_price_desc'.titleize,
                          :extra1_unit_price_desc => 'extra1_unit_price_desc'.titleize,
                          :extra2_unit_price_desc => 'extra2_unit_price_desc'.titleize,
                          :extra3_unit_price_desc => 'extra3_unit_price_desc'.titleize,
                          :extra4_unit_price_desc => 'extra4_unit_price_desc'.titleize
                          
    ws_settings.processor_unit_price_desc.should == 'processor_unit_price_desc'.humanize.downcase
    ws_settings.motherboard_unit_price_desc.should == 'motherboard_unit_price_desc'.humanize.downcase
    ws_settings.power_supply_unit_price_desc.should == 'power_supply_unit_price_desc'.humanize.downcase
    ws_settings.case_unit_price_desc.should == 'case_unit_price_desc'.humanize.downcase
    ws_settings.keyboard_unit_price_desc.should == 'keyboard_unit_price_desc'.humanize.downcase
    ws_settings.mouse_unit_price_desc.should == 'mouse_unit_price_desc'.humanize.downcase
    ws_settings.speakers_unit_price_desc.should == 'speakers_unit_price_desc'.humanize.downcase
    ws_settings.monitor_unit_price_desc.should == 'monitor_unit_price_desc'.humanize.downcase
    ws_settings.external_network_card_unit_price_desc.should == 'external_network_card_unit_price_desc'.humanize.downcase
    ws_settings.external_video_card_unit_price_desc.should == 'external_video_card_unit_price_desc'.humanize.downcase
    ws_settings.external_power_supply_unit_price_desc.should == 'external_power_supply_unit_price_desc'.humanize.downcase
    ws_settings.extra1_unit_price_desc.should == 'extra1_unit_price_desc'.humanize.downcase
    ws_settings.extra2_unit_price_desc.should == 'extra2_unit_price_desc'.humanize.downcase
    ws_settings.extra3_unit_price_desc.should == 'extra3_unit_price_desc'.humanize.downcase
    ws_settings.extra4_unit_price_desc.should == 'extra4_unit_price_desc'.humanize.downcase
  end
  
end