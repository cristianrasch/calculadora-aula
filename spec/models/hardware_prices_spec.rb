require 'spec_helper'

describe HardwarePrices do
  
  it "should downcase its attrs before saving" do
    hardware_prices = Factory :hardware_prices, :ram_unit_price_desc => 'ram_unit_price_desc'.titleize,
                              :hd_unit_price_desc => 'hd_unit_price_desc'.titleize,
                              :network_cable_unit_price_desc => 'network_cable_unit_price_desc'.titleize,
                              :switch_port_unit_price_desc => 'switch_port_unit_price_desc'.titleize,
                              :printer_unit_price_desc => 'printer_unit_price_desc'.titleize,
                              :scanner_unit_price_desc => 'scanner_unit_price_desc'.titleize,
                              :rj45_connector_unit_price_desc => 'rj45_connector_unit_price_desc'.titleize,
                              :ups_unit_price_desc => 'ups_unit_price_desc'.titleize
    
    hardware_prices.ram_unit_price_desc.should eql('ram_unit_price_desc'.humanize.downcase) 
    hardware_prices.hd_unit_price_desc.should eql('hd_unit_price_desc'.humanize.downcase)
    hardware_prices.network_cable_unit_price_desc.should eql('network_cable_unit_price_desc'.humanize.downcase)
    hardware_prices.switch_port_unit_price_desc.should eql('switch_port_unit_price_desc'.humanize.downcase)
    hardware_prices.printer_unit_price_desc.should eql('printer_unit_price_desc'.humanize.downcase)
    hardware_prices.scanner_unit_price_desc.should eql('scanner_unit_price_desc'.humanize.downcase)
    hardware_prices.rj45_connector_unit_price_desc.should eql('rj45_connector_unit_price_desc'.humanize.downcase)
    hardware_prices.ups_unit_price_desc.should eql('ups_unit_price_desc'.humanize.downcase) 
  end
  
end