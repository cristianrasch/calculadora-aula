class CreateBudgets < ActiveRecord::Migration
  def self.up
    create_table :budgets do |t|
      t.string :name, :null => false
      t.text :description

      t.timestamps
    end
    
    add_index :budgets, :name, :unique => true
  end

  def self.down
    drop_table :budgets
  end
end
