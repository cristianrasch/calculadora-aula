# coding: utf-8

module ApplicationHelper
  
  def model_not_found(clazz)
    "#{t 'msgs.not_found'} #{clazz.model_name.human.pluralize}"
  end
  
  def yes_no_select(object, method, options = {}, html_options = {})
    select object, method, [[t('msgs.yes_txt').humanize, 1], [t('msgs.no_txt').humanize, 0]], options, html_options
  end
  
  def yes_no(val)
    val ? t('msgs.yes_txt').humanize : t('msgs.no_txt').humanize
  end
  
  def strong(content)
    content_tag :strong, content 
  end
  
  def em(content)
    content_tag :em, content 
  end
  
  def total_cost_desc(arr, join_str='+', clazz=nil)
    em "(#{arr.map{ |elem| clazz ? clazz.human_attribute_name(elem) : elem }.join " #{join_str} "})"
  end
  
  def remove_zeros(matrix)
    matrix.delete_if {|arr| 
      elem = arr.last
      (elem.kind_of?(String) && elem.match(/\$\s*0(,|.)00$/)) ||
        (elem.kind_of?(Numeric) && elem.zero?)
    }
  end
  
  def curr_opts_for obj, attr
    content_tag :p, :class => 'curr_opts hidden' do
      content_tag(:input, nil, :name => "#{obj.class.to_s.underscore}[#{attr}_curr]", 
                  :type => 'radio',
                  :value => Currency::ARS,
                  :checked => obj.send("#{attr}_curr") == Currency::ARS ? 'checked' : nil)+' '+
      t('msgs.currency.ars').humanize.html_safe+' '+      
      content_tag(:input, nil, :name => "#{obj.class.to_s.underscore}[#{attr}_curr]", 
                  :type => 'radio',
                  :value => Currency::USD,
                  :checked => obj.send("#{attr}_curr") == Currency::USD ? 'checked' : nil)+' '+
      t('msgs.currency.usd').humanize.html_safe
    end
  end
  
  def nbr_to_curr obj, attr
    loc = I18n.locale
    if obj.respond_to? "#{attr}_curr"
      I18n.locale = case obj.send "#{attr}_curr"
                      when Currency::ARS then 'es-AR'
                      when Currency::USD then 'en'
                    end
    else
      I18n.locale = I18n.default_locale
    end
    u = t 'number.currency.format.unit'
    s = t 'number.currency.format.separator'
    I18n.locale = loc
    
    number_to_currency obj.send(attr), :unit => u, :separator => s
  end
  
  def curr_params obj, attr
    loc = I18n.locale
    
    I18n.locale = case obj.send("#{attr}_curr")
                    when Currency::ARS then 'es-AR'
                    when Currency::USD then 'en'
                  end
    
    u = t 'number.currency.format.unit'
    s = t 'number.currency.format.separator'
    I18n.locale = loc
    {:unit => u, :separator => s}
  end
  
end
