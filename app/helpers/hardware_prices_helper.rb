module HardwarePricesHelper
  
  def hp_reference_values(hw_prices)
    # ITEM, UNIT PRICE.
    items = []
    items << [HardwarePrices.human_attribute_name('ram_unit_price').humanize, 
              nbr_to_curr(hw_prices, :ram_unit_price)]
    items << [HardwarePrices.human_attribute_name('hd_unit_price').humanize, 
              nbr_to_curr(hw_prices, :hd_unit_price)]
    items << [HardwarePrices.human_attribute_name('network_cable_unit_price').humanize, 
              nbr_to_curr(hw_prices, :network_cable_unit_price)]
    items << [HardwarePrices.human_attribute_name('switch_port_unit_price').humanize, 
              nbr_to_curr(hw_prices, :switch_port_unit_price)]
    items << [HardwarePrices.human_attribute_name('printer_unit_price').humanize, 
              nbr_to_curr(hw_prices, :printer_unit_price)]
    items << [HardwarePrices.human_attribute_name('scanner_unit_price').humanize, 
              nbr_to_curr(hw_prices, :scanner_unit_price)]
    items << [HardwarePrices.human_attribute_name('rj45_connector_unit_price').humanize, 
              nbr_to_curr(hw_prices, :rj45_connector_unit_price)]
    items << [HardwarePrices.human_attribute_name('ups_unit_price').humanize, 
              nbr_to_curr(hw_prices, :ups_unit_price)]
              
    remove_zeros items
  end
  
end
