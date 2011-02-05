require 'test_helper'

class HardwarePricesTest < ActiveSupport::TestCase
  
  test "downcase_attrs" do
    hardware_prices = Factory :hardware_prices, :ram_unit_price_desc => 'ram_unit_price_desc'.titleize,
                              :hd_unit_price_desc => 'hd_unit_price_desc'.titleize,
                              :network_cable_unit_price_desc => 'network_cable_unit_price_desc'.titleize,
                              :switch_port_unit_price_desc => 'switch_port_unit_price_desc'.titleize,
                              :laser_printer_price_desc => 'laser_printer_price_desc'.titleize,
                              :scanner_price_desc => 'scanner_price_desc'.titleize,
                              :rj45_connector_unit_price_desc => 'rj45_connector_unit_price_desc'.titleize,
                              :ups_price_desc => 'ups_price_desc'.titleize
    assert_equal 'ram_unit_price_desc'.humanize.downcase, hardware_prices.ram_unit_price_desc
    assert_equal 'hd_unit_price_desc'.humanize.downcase, hardware_prices.hd_unit_price_desc
    assert_equal 'network_cable_unit_price_desc'.humanize.downcase, 
                  hardware_prices.network_cable_unit_price_desc
    assert_equal 'switch_port_unit_price_desc'.humanize.downcase, 
                  hardware_prices.switch_port_unit_price_desc
    assert_equal 'laser_printer_price_desc'.humanize.downcase, 
                  hardware_prices.laser_printer_price_desc
    assert_equal 'scanner_price_desc'.humanize.downcase, 
                  hardware_prices.scanner_price_desc
    assert_equal 'rj45_connector_unit_price_desc'.humanize.downcase, 
                  hardware_prices.rj45_connector_unit_price_desc
    assert_equal 'ups_price_desc'.humanize.downcase, hardware_prices.ups_price_desc
  end
  
end
