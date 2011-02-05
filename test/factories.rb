Factory.define :budget do |b|
  b.sequence(:name) {|n| "Presupuesto #{n}.."}
  b.description 'Alguna nota explicativa..'
end

Factory.define :general_settings do |gs|
  gs.students_count 45
  gs.students_per_workstation 3
  gs.teachers_count 1
  gs.clients_per_server 20
end

Factory.define :hardware_prices do |hp|
  hp.ram_unit_price 20
  hp.ram_unit_price_desc 'h1. Give RedCloth a try!'
  hp.hd_unit_price 2
  hp.hd_unit_price_desc 'A *simple* paragraph with'
  hp.network_cable_unit_price 0.5
  hp.network_cable_unit_price_desc 'some _emphasis_'
  hp.switch_port_unit_price 10
  hp.switch_port_unit_price_desc 'and a "link":http://www.google.com'
  hp.printer_unit_price 100
  hp.scanner_unit_price 101
  hp.scanner_unit_price_desc '* an item'
  hp.rj45_connector_unit_price 0.5
  hp.ups_unit_price 150
end

Factory.define :lan_settings do |ls|
  ls.ports_per_switch 24
  ls.medium_distance_bt_pcs_switch 7
  ls.installation_materials_and_wiring_cost 100
end

Factory.define :workstations_settings do |ws|
  ws.target WorkstationsSettings::Target::STUDENTS
  ws.ram_size_in_gigs 1
  ws.hd_size_in_gigs 50
  ws.processor_unit_price 100
  ws.motherboard_unit_price 70
  ws.power_supply_unit_price 20
  ws.case_unit_price 20
  ws.keyboard_unit_price 10
  ws.mouse_unit_price 10
  ws.speakers_unit_price 10
  ws.monitor_unit_price 150
  ws.external_network_card_unit_price 0
  ws.external_video_card_unit_price 0
  ws.external_power_supply_unit_price 0
  ws.extra1_unit_price 0
  ws.extra2_unit_price 0
  ws.extra3_unit_price 0
  ws.extra4_unit_price 0
end

Factory.define :furnishings do |f|
  f.target Furnishings::Target::STUDENTS
  f.chairs_unit_price 50
  f.chairs_per_workstation {|fr| fr.target == Furnishings::Target::STUDENTS ? 3 : 1}
  f.tables_unit_price 70
  f.tables_per_workstation 1
  f.others_unit_price 0
  f.others_per_workstation 1
end

Factory.define :software do |s|
  s.target Software::Target::STUDENTS_STANDALONE
  s.mask Software::Target::STUDENTS_STANDALONE_MASK
  s.free_soft_only true
  s.os_unit_price 200
  s.office_suite_unit_price 99
  s.class_mon_n_ctrl_apps_unit_price 30
  s.tc_srv_unit_price 0
  s.web_srv_unit_price 0
  s.proxy_srv_unit_price 0
  s.file_n_print_srv_unit_price 0
  s.tc_lic_unit_price 0
  s.spec_apps_unit_price 0
  s.others_unit_price 0
end

Factory.define :settings do |s|
  s.students_standalone_workstations_enabled false
  s.teachers_standalone_workstations_enabled true
  s.thin_clients_enabled true
  s.thin_clients_server_enabled true
  s.lan_enabled true
  s.ups_enabled true
  s.printers_count 1
  s.scanners_count 1
  s.students_furnishings_enabled true
  s.teachers_furnishings_enabled true
  s.servers_furnishings_enabled true
  s.building_improvements_cost 0
  s.electric_installation_cost 0
end