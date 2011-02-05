class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.boolean :students_standalone_workstations_enabled
      t.boolean :teachers_standalone_workstations_enabled
      t.boolean :thin_clients_enabled
      t.boolean :thin_clients_server_enabled
      t.boolean :lan_enabled
      t.boolean :ups_enabled
      t.integer :printers_count
      t.integer :scanners_count
      t.boolean :students_furnishings_enabled
      t.boolean :teachers_furnishings_enabled
      t.boolean :servers_furnishings_enabled
      t.decimal :building_improvements_cost, :precision => 8, :scale => 2
      t.string :building_improvements_cost_desc
      t.decimal :electric_installation_cost, :precision => 8, :scale => 2
      t.string :electric_installation_cost_desc
      
      t.references :budget
      
      t.timestamps
    end
    
    add_index :settings, :budget_id, :unique => true
  end

  def self.down
    drop_table :settings
  end
end
