class CreateWorkstationsSettings < ActiveRecord::Migration
  def self.up
    create_table :workstations_settings do |t|
      t.integer :target
      t.float :ram_size_in_gigs
      t.integer :hd_size_in_gigs
      
      t.decimal :processor_unit_price, :precision => 8, :scale => 2
      t.string :processor_unit_price_desc
      
      t.decimal :motherboard_unit_price, :precision => 8, :scale => 2
      t.string :motherboard_unit_price_desc
      
      t.decimal :power_supply_unit_price, :precision => 8, :scale => 2
      t.string :power_supply_unit_price_desc
      
      t.decimal :case_unit_price, :precision => 8, :scale => 2
      t.string :case_unit_price_desc
      
      t.decimal :keyboard_unit_price, :precision => 8, :scale => 2
      t.string :keyboard_unit_price_desc
      
      t.decimal :mouse_unit_price, :precision => 8, :scale => 2
      t.string :mouse_unit_price_desc
      
      t.decimal :speakers_unit_price, :precision => 8, :scale => 2
      t.string :speakers_unit_price_desc
      
      t.decimal :monitor_unit_price, :precision => 8, :scale => 2
      t.string :monitor_unit_price_desc
      
      t.decimal :external_network_card_unit_price, :precision => 8, :scale => 2
      t.string :external_network_card_unit_price_desc
      
      t.decimal :external_video_card_unit_price, :precision => 8, :scale => 2
      t.string :external_video_card_unit_price_desc
      
      t.decimal :external_power_supply_unit_price, :precision => 8, :scale => 2
      t.string :external_power_supply_unit_price_desc
      
      t.decimal :extra1_unit_price, :precision => 8, :scale => 2
      t.string :extra1_unit_price_desc
      
      t.decimal :extra2_unit_price, :precision => 8, :scale => 2
      t.string :extra2_unit_price_desc
      
      t.decimal :extra3_unit_price, :precision => 8, :scale => 2
      t.string :extra3_unit_price_desc
      
      t.decimal :extra4_unit_price, :precision => 8, :scale => 2
      t.string :extra4_unit_price_desc

      t.references :budget

      t.timestamps
    end
    
    add_index :workstations_settings, :budget_id
  end

  def self.down
    drop_table :workstations_settings
  end
end
