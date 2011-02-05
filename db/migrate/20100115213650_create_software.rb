class CreateSoftware < ActiveRecord::Migration
  def self.up
    create_table :software do |t|
      t.integer :target
      t.integer :mask
      t.decimal :os, :precision => 8, :scale => 2
      t.string :os_desc
      
      t.decimal :office_suite, :precision => 8, :scale => 2
      t.string :office_suite_desc
      
      t.decimal :class_monitoring_n_ctrl_apps, :precision => 8, :scale => 2
      t.string :class_monitoring_n_ctrl_apps_desc
      
      t.decimal :tc_server, :precision => 8, :scale => 2
      t.string :tc_server_desc
      
      t.decimal :web_server, :precision => 8, :scale => 2
      t.string :web_server_desc
      
      t.decimal :proxy_server, :precision => 8, :scale => 2
      t.string :proxy_server_desc
      
      t.decimal :file_n_printing_server, :precision => 8, :scale => 2
      t.string :file_n_printing_server_desc
      
      t.decimal :tc_license, :precision => 8, :scale => 2
      t.string :tc_license_desc
      
      t.decimal :specialized_apps, :precision => 8, :scale => 2
      t.string :specialized_apps_desc
      
      t.decimal :others, :precision => 8, :scale => 2
      t.string :others_desc
      
      t.boolean :free_soft_only, :precision => 8, :scale => 2
      
      t.references :budget

      t.timestamps
    end
    
    add_index :software, :budget_id
  end

  def self.down
    drop_table :software
  end
end
