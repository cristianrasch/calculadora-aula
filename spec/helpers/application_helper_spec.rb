# coding: utf-8
require 'spec_helper'

describe ApplicationHelper do
  
  it "should display a model_not found msg" do
    msg = helper.model_not_found Budget
    msg.should match(/#{I18n.t('msgs.not_found')}/)
    msg.should match(/presupuestos/i) 
  end
  
  it "should display a yes_no select" do
    sel = helper.yes_no_select('parent', 'child_id', :include_blank => true).to_s
    sel.should match(/parent[child_id]/)
    sel.should match(/option value=""/)
    sel.should match(/<option value="0">no<\/option>/i)
  end
  
  it "should display a yes_no msg" do
    helper.yes_no(false).should == 'No'
  end
  
  it "should turn txt stronger" do
    helper.strong('xxx').should match(/<strong>\w+<\/strong>/)
  end
  
  it "should turn txt more emphatic" do
    helper.em('xxx').should match(/<em>\w+<\/em>/)
  end
  
  it "should return a total_cost desc msg" do
    msg = helper.total_cost_desc %w{ab cd efg}, '-'
    msg.should match(/<em>\((\w|\s|-)+\)<\/em>/)
  end
  
  it "should remove zeros" do
    helper.remove_zeros([[1, 2],[3, 0]]).should have(1).item
    helper.remove_zeros([[1, 'xxx $ 0,00'],[3, 0.55]]).should have(1).item
    helper.remove_zeros([[1, 2.34],[3, 'any value..']]).should have(2).items
  end
  
  def curr_opts_for obj, attr
    content_tag :p, :class => 'curr_opts hidden' do
      t('msgs.currency.ars').humanize+'&nbsp;'+
      content_tag(:input, nil, :name => "#{obj.class.to_s.underscore}[#{attr}_curr]", 
                  :type => 'radio',
                  :value => Currency::ARS,
                  :checked => obj.send("#{attr}_curr") == Currency::ARS ? 'checked' : nil)+'&nbsp;'+
      t('msgs.currency.usd').humanize+'&nbsp;'+
      content_tag(:input, nil, :name => "#{obj.class.to_s.underscore}[#{attr}_curr]", 
                  :type => 'radio',
                  :value => Currency::USD,
                  :checked => obj.send("#{attr}_curr") == Currency::USD ? 'checked' : nil)
    end
  end
  
  it "shoud display currency options for obj's attrs" do
    hp = Factory.build :hardware_prices, 
                       :ram_unit_price_curr => Currency::USD
    attr = :ram_unit_price
                       
    curr_opts = helper.curr_opts_for hp, attr
    curr_opts.should match(/p class="curr_opts hidden".+\/p/)    
    
    curr_opts.should match(/input name=\"hardware_prices\[#{attr}_curr\]\".+value=\"1\"/)
    curr_opts.should match(/input checked=\"checked\" name=\"hardware_prices\[#{attr}_curr\]\".+value=\"2\"/)
    
    #curr_opts.should match(/.+Peso&nbsp;<input name=\"hardware_prices\[#{attr}_curr\]\" type=\"radio\" value=\"1\">.+/)
    #curr_opts.should match(/.+Dólar&nbsp;<input checked=\"checked\" name=\"hardware_prices\[ram_unit_price_curr\]\" type=\"radio\" value=\"2\">.+/)
    
    curr_opts.should match(/<\/p>/)
  end
  
  it "should display currencies properly" do
    hp = Factory.build :hardware_prices, 
                       :hd_unit_price_curr => Currency::USD
         
    
    helper.nbr_to_curr(hp, :ram_unit_price).should match(/^\$\s\d+,\d+$/)
    I18n.locale = :en
    helper.nbr_to_curr(hp, :hd_unit_price).should match(/^u\$s\s\d+.\d+$/)
    I18n.locale.should == :en
    
    ls = Factory(:budget).build_lan_settings
    helper.nbr_to_curr(ls, :switches_cost).should match(/^\$\s\d+,\d+$/)
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
  
  it "should return proper currency params" do
    budget = Factory :budget
    budget.hardware_prices = Factory.build :hardware_prices, 
                                           :ram_unit_price_curr => Currency::USD
    budget.workstations_settings << Factory.build(:workstations_settings)
    params = helper.curr_params budget.hardware_prices, :ram_unit_price
    params[:unit].should == 'u$s'
    params[:separator].should == '.'
    
    params = helper.curr_params budget.hardware_prices, :hd_unit_price
    params[:unit].should == '$'
    params[:separator].should == ','
  end
  
end