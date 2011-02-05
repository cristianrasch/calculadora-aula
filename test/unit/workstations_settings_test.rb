require 'test_helper'

class WorkstationsSettingsTest < ActiveSupport::TestCase
  
  test "*_cost" do
    workstations_settings = @budget.build_students_workstations_settings Factory.attributes_for(:workstations_settings)

    assert_not_nil workstations_settings.ram_cost
    assert_not_nil workstations_settings.hd_cost

    total_cost = workstations_settings.ram_cost + workstations_settings.hd_cost
    total_cost += WorkstationsSettings.column_names.select {|col|
                    /\w+_unit_price\z/.match col
                  }.inject(0) { |sum, col_price|
                     sum += workstations_settings.send(col_price)
                  }
    assert_equal total_cost, workstations_settings.total_cost
  end
  
  test "after_initialize" do
    teachers_workstations_settings = WorkstationsSettings.new :target => WorkstationsSettings::Target::TEACHERS
    assert_equal 2, teachers_workstations_settings.ram_size_in_gigs
    
    servers_workstations_settings = WorkstationsSettings.new :target => WorkstationsSettings::Target::SERVERS
    assert_equal 5, servers_workstations_settings.ram_size_in_gigs
    
    thin_clients_workstations_settings = WorkstationsSettings.new :target => WorkstationsSettings::Target::THIN_CLIENTS
    assert_equal 1, thin_clients_workstations_settings.ram_size_in_gigs
  end
  
  test "downcase_attrs" do
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
                          
    assert_equal 'processor_unit_price_desc'.humanize.downcase, 
                  ws_settings.processor_unit_price_desc
                  
    assert_equal 'motherboard_unit_price_desc'.humanize.downcase, 
                  ws_settings.motherboard_unit_price_desc
    assert_equal 'power_supply_unit_price_desc'.humanize.downcase, 
                  ws_settings.power_supply_unit_price_desc
    assert_equal 'case_unit_price_desc'.humanize.downcase, 
                  ws_settings.case_unit_price_desc
    assert_equal 'keyboard_unit_price_desc'.humanize.downcase, 
                  ws_settings.keyboard_unit_price_desc
    assert_equal 'mouse_unit_price_desc'.humanize.downcase, 
                  ws_settings.mouse_unit_price_desc
    assert_equal 'speakers_unit_price_desc'.humanize.downcase, 
                  ws_settings.speakers_unit_price_desc
    assert_equal 'monitor_unit_price_desc'.humanize.downcase, 
                  ws_settings.monitor_unit_price_desc
    assert_equal 'external_network_card_unit_price_desc'.humanize.downcase, 
                  ws_settings.external_network_card_unit_price_desc
    assert_equal 'external_video_card_unit_price_desc'.humanize.downcase, 
                  ws_settings.external_video_card_unit_price_desc
    assert_equal 'external_power_supply_unit_price_desc'.humanize.downcase, 
                  ws_settings.external_power_supply_unit_price_desc
    assert_equal 'extra1_unit_price_desc'.humanize.downcase, 
                  ws_settings.extra1_unit_price_desc
    assert_equal 'extra2_unit_price_desc'.humanize.downcase, 
                  ws_settings.extra2_unit_price_desc
    assert_equal 'extra3_unit_price_desc'.humanize.downcase, 
                  ws_settings.extra3_unit_price_desc
    assert_equal 'extra4_unit_price_desc'.humanize.downcase, 
                  ws_settings.extra4_unit_price_desc
                  
  end

  protected

  def setup
    @budget = Factory :budget
    @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
  end

end
