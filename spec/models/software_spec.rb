require 'spec_helper'

describe Software do
  
  it "should enumerate only price cols" do
    cols = Software.price_cols
    cols.should_not include('id')
    cols.should_not include('os_unit_price_desc')
  end
  
  it "should enumerate proper price cols" do
    sw = Factory.build :software
    sw.price_cols.should include('os_unit_price')
    sw.price_cols.should include('office_suite_unit_price')
    sw.price_cols.should include('class_mon_n_ctrl_apps_unit_price')
    sw.price_cols.should_not include('web_srv_unit_price')
  end
  
  it "should have a total cost" do
    sw = Factory.build :software, :free_soft_only => false
    sw.total_cost.should_not == 0
  end
  
  it "should handle mask conversions" do
    Software::Target.target_mask(Software::Target::STUDENTS_STANDALONE).should == Software::Target::STUDENTS_STANDALONE_MASK
    Software::Target.target_mask(Software::Target::TEACHERS_STANDALONE).should == Software::Target::TEACHERS_STANDALONE_MASK
    Software::Target.target_mask(Software::Target::TC_SERVER).should == Software::Target::TC_SERVER_MASK
    Software::Target.target_mask(Software::Target::TC).should == Software::Target::TC_MASK
  end
  
  it "should be properly initialized" do
    students_standalone_sw = Software.new :target => Software::Target::STUDENTS_STANDALONE, 
                                          :mask => Software::Target::STUDENTS_STANDALONE_MASK
    students_standalone_sw.os_unit_price.should == 200
    
    teachers_standalone_sw = Software.new :target => Software::Target::TEACHERS_STANDALONE, 
                                          :mask => Software::Target::TEACHERS_STANDALONE_MASK
    teachers_standalone_sw.os_unit_price.should == 200
    
    tc_server_sw = Software.new :target => Software::Target::TC_SERVER, 
                                          :mask => Software::Target::TC_SERVER_MASK
    tc_server_sw.os_unit_price.should == 999
    
    tc_sw = Software.new :target => Software::Target::TC, 
                         :mask => Software::Target::TC_MASK
    tc_sw.os_unit_price.should == 120                                      
  end
  
  it "should downcase its attrs before saving" do
    software = Factory :software, :os_unit_price_desc => 'os_unit_price_desc'.titleize,
                       :office_suite_unit_price_desc => 'office_suite_unit_price_desc'.titleize,
                       :class_mon_n_ctrl_apps_unit_price_desc => 'class_mon_n_ctrl_apps_unit_price_desc'.titleize,
                       :tc_srv_unit_price_desc => 'tc_srv_unit_price_desc'.titleize,
                       :web_srv_unit_price_desc => 'web_srv_unit_price_desc'.titleize,
                       :proxy_srv_unit_price_desc => 'proxy_srv_unit_price_desc'.titleize,
                       :file_n_print_srv_unit_price_desc => 'file_n_print_srv_unit_price_desc'.titleize,
                       :tc_lic_unit_price_desc => 'tc_lic_unit_price_desc'.titleize,
                       :spec_apps_unit_price_desc => 'spec_apps_unit_price_desc'.titleize,
                       :others_unit_price_desc => 'others_unit_price_desc'.titleize
    
    software.os_unit_price_desc.should == 'os_unit_price_desc'.humanize.downcase
    software.office_suite_unit_price_desc.should == 'office_suite_unit_price_desc'.humanize.downcase
    software.class_mon_n_ctrl_apps_unit_price_desc.should == 'class_mon_n_ctrl_apps_unit_price_desc'.humanize.downcase
    software.tc_srv_unit_price_desc.should == 'tc_srv_unit_price_desc'.humanize.downcase
    software.web_srv_unit_price_desc.should == 'web_srv_unit_price_desc'.humanize.downcase
    software.proxy_srv_unit_price_desc.should == 'proxy_srv_unit_price_desc'.humanize.downcase
    software.file_n_print_srv_unit_price_desc.should == 'file_n_print_srv_unit_price_desc'.humanize.downcase
    software.tc_lic_unit_price_desc.should == 'tc_lic_unit_price_desc'.humanize.downcase
    software.spec_apps_unit_price_desc.should == 'spec_apps_unit_price_desc'.humanize.downcase
    software.others_unit_price_desc.should == 'others_unit_price_desc'.humanize.downcase
  end
  
end