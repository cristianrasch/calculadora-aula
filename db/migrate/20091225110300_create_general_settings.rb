class CreateGeneralSettings < ActiveRecord::Migration
  def self.up
    create_table :general_settings do |t|
      t.integer :students_count
      t.integer :students_per_workstation
      t.integer :teachers_count
      t.integer :clients_per_server
      
      t.references :budget

      t.timestamps
    end
    
    add_index :general_settings, :budget_id, :unique => true
  end

  def self.down
    drop_table :general_settings
  end
end
