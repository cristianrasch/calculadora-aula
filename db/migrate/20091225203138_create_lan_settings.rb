class CreateLanSettings < ActiveRecord::Migration
  def self.up
    create_table :lan_settings do |t|
      t.integer :ports_per_switch
      t.string :ports_per_switch_desc
      t.float :medium_distance_bt_pcs_switch
      t.string :medium_distance_bt_pcs_switch_desc
      t.decimal :installation_materials_and_wiring_cost, :precision => 8, 
                :scale => 2
      t.string :installation_materials_and_wiring_cost_desc

      t.references :budget

      t.timestamps
    end
    
    add_index :lan_settings, :budget_id, :unique => true
  end

  def self.down
    drop_table :lan_settings
  end
end
