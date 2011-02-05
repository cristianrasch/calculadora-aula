class CreateHardwarePrices < ActiveRecord::Migration
  def self.up
    create_table :hardware_prices do |t|
      t.decimal :ram_unit_price, :precision => 8, :scale => 2
      t.string :ram_unit_price_desc
      t.decimal :hd_unit_price, :precision => 8, :scale => 2
      t.string :hd_unit_price_desc
      t.decimal :network_cable_unit_price, :precision => 8, :scale => 2
      t.string :network_cable_unit_price_desc
      t.decimal :switch_port_unit_price, :precision => 8, :scale => 2
      t.string :switch_port_unit_price_desc
      t.decimal :laser_printer_price, :precision => 8, :scale => 2
      t.string :laser_printer_price_desc
      t.decimal :scanner_price, :precision => 8, :scale => 2
      t.string :scanner_price_desc
      t.decimal :rj45_connector_unit_price, :precision => 8, :scale => 2
      t.string :rj45_connector_unit_price_desc
      t.decimal :ups_price, :precision => 8, :scale => 2
      t.string :ups_price_desc
      
      t.references :budget

      t.timestamps
    end
    
    add_index :hardware_prices, :budget_id, :unique => true
  end

  def self.down
    drop_table :hardware_prices
  end
end
