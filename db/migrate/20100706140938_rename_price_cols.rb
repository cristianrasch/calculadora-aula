class RenamePriceCols < ActiveRecord::Migration
  def self.up
    # hardware_prices
    rename_column :hardware_prices, :laser_printer_price, :printer_unit_price
    rename_column :hardware_prices, :laser_printer_price_desc, :printer_unit_price_desc
    rename_column :hardware_prices, :laser_printer_price_curr, :printer_unit_price_curr
    rename_column :hardware_prices, :scanner_price, :scanner_unit_price
    rename_column :hardware_prices, :scanner_price_desc, :scanner_unit_price_desc
    rename_column :hardware_prices, :scanner_price_curr, :scanner_unit_price_curr
    rename_column :hardware_prices, :ups_price, :ups_unit_price
    rename_column :hardware_prices, :ups_price_desc, :ups_unit_price_desc
    rename_column :hardware_prices, :ups_price_curr, :ups_unit_price_curr
    
    # furnishings
    rename_column :furnishings, :chair_unit_price, :chairs_unit_price
    rename_column :furnishings, :chair_unit_price_desc, :chairs_unit_price_desc
    rename_column :furnishings, :table_unit_price, :tables_unit_price
    rename_column :furnishings, :table_unit_price_desc, :tables_unit_price_desc
    
    # software
    rename_column :software, :os, :os_unit_price
    rename_column :software, :os_desc, :os_unit_price_desc
    rename_column :software, :os_curr, :os_unit_price_curr
    rename_column :software, :office_suite, :office_suite_unit_price
    rename_column :software, :office_suite_desc, :office_suite_unit_price_desc
    rename_column :software, :office_suite_curr, :office_suite_unit_price_curr
    rename_column :software, :class_monitoring_n_ctrl_apps, :class_mon_n_ctrl_apps_unit_price
    rename_column :software, :class_monitoring_n_ctrl_apps_desc, :class_mon_n_ctrl_apps_unit_price_desc
    rename_column :software, :class_monitoring_n_ctrl_apps_curr, :class_mon_n_ctrl_apps_unit_price_curr
    rename_column :software, :tc_server, :tc_srv_unit_price
    rename_column :software, :tc_server_desc, :tc_srv_unit_price_desc
    rename_column :software, :tc_server_curr, :tc_srv_unit_price_curr
    rename_column :software, :web_server, :web_srv_unit_price
    rename_column :software, :web_server_desc, :web_srv_unit_price_desc
    rename_column :software, :web_server_curr, :web_srv_unit_price_curr
    rename_column :software, :proxy_server, :proxy_srv_unit_price
    rename_column :software, :proxy_server_desc, :proxy_srv_unit_price_desc
    rename_column :software, :proxy_server_curr, :proxy_srv_unit_price_curr
    rename_column :software, :file_n_printing_server, :file_n_print_srv_unit_price
    rename_column :software, :file_n_printing_server_desc, :file_n_print_srv_unit_price_desc
    rename_column :software, :file_n_printing_server_curr, :file_n_print_srv_unit_price_curr
    rename_column :software, :tc_license, :tc_lic_unit_price
    rename_column :software, :tc_license_desc, :tc_lic_unit_price_desc
    rename_column :software, :tc_license_curr, :tc_lic_unit_price_curr
    rename_column :software, :specialized_apps, :spec_apps_unit_price
    rename_column :software, :specialized_apps_desc, :spec_apps_unit_price_desc
    rename_column :software, :specialized_apps_curr, :spec_apps_unit_price_curr
    rename_column :software, :others, :others_unit_price
    rename_column :software, :others_desc, :others_unit_price_desc
    rename_column :software, :others_curr, :others_unit_price_curr
  end

  def self.down
    # hardware_prices
    rename_column :hardware_prices, :printer_unit_price, :laser_printer_price
    rename_column :hardware_prices, :printer_unit_price_desc, :laser_printer_price_desc
    rename_column :hardware_prices, :printer_unit_price_curr, :laser_printer_price_curr
    rename_column :hardware_prices, :scanner_unit_price, :scanner_price
    rename_column :hardware_prices, :scanner_unit_price_desc, :scanner_price_desc
    rename_column :hardware_prices, :scanner_unit_price_curr, :scanner_price_curr
    rename_column :hardware_prices, :ups_unit_price, :ups_price
    rename_column :hardware_prices, :ups_unit_price, :ups_price_desc
    rename_column :hardware_prices, :ups_unit_curr, :ups_price_curr
    
    # furnishings
    rename_column :furnishings, :chairs_unit_price, :chair_unit_price
    rename_column :furnishings, :chairs_unit_price_desc, :chair_unit_price_desc
    rename_column :furnishings, :tables_unit_price, :table_unit_price
    rename_column :furnishings, :tables_unit_price_desc, :table_unit_price_desc
    
    # software
    rename_column :software, :os_unit_price, :os
    rename_column :software, :os_unit_price_desc, :os_desc
    rename_column :software, :office_suite_unit_price, :office_suite
    rename_column :software, :office_suite_unit_price_desc, :office_suite_desc
    rename_column :software, :class_mon_n_ctrl_apps_unit_price, :class_monitoring_n_ctrl_apps
    rename_column :software, :class_mon_n_ctrl_apps_unit_price_desc, :class_monitoring_n_ctrl_apps_desc
    rename_column :software, :tc_srv_unit_price, :tc_server
    rename_column :software, :tc_srv_unit_price_desc, :tc_server_desc
    rename_column :software, :web_srv_unit_price, :web_server
    rename_column :software, :web_srv_unit_price_desc, :web_server_desc
    rename_column :software, :proxy_srv_unit_price, :proxy_server
    rename_column :software, :proxy_srv_unit_price_desc, :proxy_server_desc
    rename_column :software, :file_n_print_srv_unit_price, :file_n_printing_server
    rename_column :software, :file_n_print_srv_unit_price_desc, :file_n_printing_server_desc
    rename_column :software, :tc_lic_unit_price, :tc_license
    rename_column :software, :tc_lic_unit_price_desc, :tc_license_desc
    rename_column :software, :spec_apps_unit_price, :specialized_apps
    rename_column :software, :spec_apps_unit_price_desc, :specialized_apps_desc
    rename_column :software, :others_unit_price, :others
    rename_column :software, :others_unit_price_desc, :others_desc
  end
end
