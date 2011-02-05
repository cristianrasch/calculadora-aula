class CreateFurnishings < ActiveRecord::Migration
  def self.up
    create_table :furnishings do |t|
      t.integer :target
      t.decimal :chair_unit_price, :precision => 8, :scale => 2
      t.string :chair_unit_price_desc
      t.integer :chairs_per_workstation
      t.decimal :table_unit_price, :precision => 8, :scale => 2
      t.string :table_unit_price_desc
      t.integer :tables_per_workstation
      t.decimal :others_unit_price, :precision => 8, :scale => 2
      t.string :others_unit_price_desc
      t.integer :others_per_workstation

      t.references :budget

      t.timestamps
    end
    
    add_index :furnishings, :budget_id
  end

  def self.down
    drop_table :furnishings
  end
end
