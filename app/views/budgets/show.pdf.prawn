pdf.text "#{Budget.model_name.human.humanize}: #{@budget.name.humanize}", :size => 20, :style => :bold
pdf.move_down 15
pdf.text @budget.description.humanize, :size => 10, :style => :italic
pdf.move_down 15

# ITEM, DESCRIPTION, UNIT PRICE, QUANTITY, SUBTOTAL.
pdf.table to_table(@budget), 
	:border_style => :grid,
  :row_colors => ["FFFFFF","DDDDDD"],
  :font_size  => 10,
  :headers => [t('msgs.item'), t('msgs.desc'), t('msgs.unit_price'), 
								t('msgs.qty'), t('msgs.subtotal')],
  :align => { 0 => :left, 1 => :left, 2 => :right, 3 => :right, 4 => :right },
  :align_headers => :center,
  :position => :center,
  :width => 550,
  :column_widths => { 0 => 225, 1 => 130, 2 => 65, 3 => 65, 4 => 65 }

pdf.move_down 20
pdf.text "#{Settings.human_attribute_name('total_cost').humanize}: #{number_to_currency(@budget.settings.total_cost)}", 
				 :size => 15, :style => :bold

pdf.start_new_page
pdf.text t('msgs.reference_values'), :size => 15, :style => :bold
pdf.move_down 15

table = gs_reference_values @budget.general_settings
unless table.empty?
	pdf.text GeneralSettings.model_name.human.humanize, :size => 10, :style => :italic
	pdf.move_down 5
	# ITEM, UNIT PRICE.
	pdf.table table, 
		:border_style => :grid,
	  :row_colors => ["FFFFFF","DDDDDD"],
	  :font_size  => 10,
	  :headers => [t('msgs.item'), t('msgs.qty')],
	  :align => { 0 => :left, 1 => :right },
	  :align_headers => :center,
	  :position => :center,
	  :width => 550,
	  :column_widths => { 0 => 275, 1 => 275 }
	pdf.move_down 15
end

table = hp_reference_values @budget.hardware_prices
unless table.empty?
	pdf.text HardwarePrices.model_name.human.humanize, :size => 10, :style => :italic
	pdf.move_down 5
	# ITEM, UNIT PRICE.
	pdf.table table, 
		:border_style => :grid,
	  :row_colors => ["FFFFFF","DDDDDD"],
	  :font_size  => 10,
	  :headers => [t('msgs.item'), t('msgs.unit_price')],
	  :align => { 0 => :left, 1 => :right },
	  :align_headers => :center,
	  :position => :center,
	  :width => 550,
	  :column_widths => { 0 => 275, 1 => 275 }
	pdf.move_down 15
end

table = ls_reference_values @budget.lan_settings
unless table.empty?
	pdf.text LanSettings.model_name.human.humanize, :size => 10, :style => :italic
	pdf.move_down 5
	# ITEM, UNIT PRICE.
	pdf.table table, 
		:border_style => :grid,
	  :row_colors => ["FFFFFF","DDDDDD"],
	  :font_size  => 10,
	  :headers => [t('msgs.item'), "#{t('msgs.qty')}/#{t('msgs.unit_price')}"],
	  :align => { 0 => :left, 1 => :right },
	  :align_headers => :center,
	  :position => :center,
	  :width => 550,
	  :column_widths => { 0 => 275, 1 => 275 }
	pdf.move_down 15
end

pdf.start_new_page

%w{students_workstations_settings teachers_workstations_settings 
	thin_clients_workstations_settings servers_workstations_settings}.each do |ws_settings|
	
	table = ws_reference_values @budget.send(ws_settings)
	next if table.empty?
	
	pdf.text Budget.human_attribute_name(ws_settings).humanize, :size => 10, :style => :italic
	pdf.move_down 5
	# ITEM, UNIT PRICE.
	pdf.table table, 
		:border_style => :grid,
	  :row_colors => ["FFFFFF","DDDDDD"],
	  :font_size  => 10,
	  :headers => [t('msgs.item'), "#{t('msgs.qty')}/#{t('msgs.unit_price')}"],
	  :align => { 0 => :left, 1 => :right },
	  :align_headers => :center,
	  :position => :center,
	  :width => 550,
	  :column_widths => { 0 => 275, 1 => 275 }
	pdf.move_down 15
end

pdf.start_new_page

%w{students_furnishings teachers_furnishings 
	servers_furnishings}.each do |furnishings|
	
	table = f_reference_values @budget.send(furnishings)
	next if table.empty?
	
	pdf.text Budget.human_attribute_name(furnishings).humanize, :size => 10, :style => :italic
	pdf.move_down 5
	# ITEM, UNIT PRICE.
	pdf.table table, 
		:border_style => :grid,
	  :row_colors => ["FFFFFF","DDDDDD"],
	  :font_size  => 10,
	  :headers => [t('msgs.item'), "#{t('msgs.qty')}/#{t('msgs.unit_price')}"],
	  :align => { 0 => :left, 1 => :right },
	  :align_headers => :center,
	  :position => :center,
	  :width => 550,
	  :column_widths => { 0 => 275, 1 => 275 }
	pdf.move_down 15
end

pdf.start_new_page

%w{students_standalone_software teachers_standalone_software 
	tc_server_software tc_software}.each do |software|
	
	table = soft_reference_values @budget.send(software)
	next if table.empty?
	
	pdf.text Budget.human_attribute_name(software).humanize, :size => 10, :style => :italic
	pdf.move_down 5
	# ITEM, UNIT PRICE.
	pdf.table table, 
		:border_style => :grid,
	  :row_colors => ["FFFFFF","DDDDDD"],
	  :font_size  => 10,
	  :headers => [t('msgs.item'), t('msgs.unit_price')],
	  :align => { 0 => :left, 1 => :right },
	  :align_headers => :center,
	  :position => :center,
	  :width => 550,
	  :column_widths => { 0 => 275, 1 => 275 }
	pdf.move_down 15
end

pdf.start_new_page

pdf.text Settings.model_name.human.humanize, :size => 10, :style => :italic
pdf.move_down 5
# ITEM, UNIT PRICE.
pdf.table s_reference_values(@budget.settings), 
	:border_style => :grid,
  :row_colors => ["FFFFFF","DDDDDD"],
  :font_size  => 10,
  :headers => [t('msgs.item'), "#{t('msgs.qty')}/#{t('msgs.unit_price')}"],
  :align => { 0 => :left, 1 => :right },
  :align_headers => :center,
  :position => :center,
  :width => 550,
  :column_widths => { 0 => 275, 1 => 275 }
pdf.move_down 15
