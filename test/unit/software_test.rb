require 'test_helper'

class SoftwareTest < ActiveSupport::TestCase
  
  test "Software#price_cols" do
    cols = Software.price_cols
    assert ! cols.include?('id')
    assert ! cols.include?('os_desc')
  end
  
  test "price_cols" do
    sw = Factory.build :software
    assert sw.price_cols.include?('os')
    assert sw.price_cols.include?('office_suite')
    assert sw.price_cols.include?('class_monitoring_n_ctrl_apps')
    assert ! sw.price_cols.include?('web_server')
  end
  
  test "total_cost" do
    sw = Factory.build :software, :free_soft_only => false
    assert ! sw.total_cost.zero?
  end
  
  test "Target#target_mask" do
    assert_equal Software::Target::STUDENTS_STANDALONE_MASK, 
                 Software::Target.target_mask(Software::Target::STUDENTS_STANDALONE)
    assert_equal Software::Target::TEACHERS_STANDALONE_MASK, 
                 Software::Target.target_mask(Software::Target::TEACHERS_STANDALONE)
    assert_equal Software::Target::TC_SERVER_MASK, 
                 Software::Target.target_mask(Software::Target::TC_SERVER)
    assert_equal Software::Target::TC_MASK, 
                 Software::Target.target_mask(Software::Target::TC)
  end
  
  test "after_initialize" do
    students_standalone_sw = Software.new :target => Software::Target::STUDENTS_STANDALONE, 
                                          :mask => Software::Target::STUDENTS_STANDALONE_MASK
    assert_equal 200, students_standalone_sw.os
    
    teachers_standalone_sw = Software.new :target => Software::Target::TEACHERS_STANDALONE, 
                                          :mask => Software::Target::TEACHERS_STANDALONE_MASK
    assert_equal 200, teachers_standalone_sw.os
    
    tc_server_sw = Software.new :target => Software::Target::TC_SERVER, 
                                          :mask => Software::Target::TC_SERVER_MASK
    assert_equal 999, tc_server_sw.os
    
    tc_sw = Software.new :target => Software::Target::TC, 
                         :mask => Software::Target::TC_MASK
    assert_equal 120, tc_sw.os                                      
  end
  
  test "downcase_attrs" do
    software = Factory :software, :os_desc => 'os_desc'.titleize,
                       :office_suite_desc => 'office_suite_desc'.titleize,
                       :class_monitoring_n_ctrl_apps_desc => 'class_monitoring_n_ctrl_apps_desc'.titleize,
                       :tc_server_desc => 'tc_server_desc'.titleize,
                       :web_server_desc => 'web_server_desc'.titleize,
                       :proxy_server_desc => 'proxy_server_desc'.titleize,
                       :file_n_printing_server_desc => 'file_n_printing_server_desc'.titleize,
                       :tc_license_desc => 'tc_license_desc'.titleize,
                       :specialized_apps_desc => 'specialized_apps_desc'.titleize,
                       :others_desc => 'others_desc'.titleize
    
    assert_equal 'os_desc'.humanize.downcase, software.os_desc
    assert_equal 'office_suite_desc'.humanize.downcase, software.office_suite_desc
    assert_equal 'class_monitoring_n_ctrl_apps_desc'.humanize.downcase, 
                  software.class_monitoring_n_ctrl_apps_desc
    assert_equal 'tc_server_desc'.humanize.downcase, software.tc_server_desc
    assert_equal 'web_server_desc'.humanize.downcase, software.web_server_desc
    assert_equal 'proxy_server_desc'.humanize.downcase, software.proxy_server_desc
    assert_equal 'file_n_printing_server_desc'.humanize.downcase, 
                  software.file_n_printing_server_desc
    assert_equal 'tc_license_desc'.humanize.downcase, software.tc_license_desc
    assert_equal 'specialized_apps_desc'.humanize.downcase, software.specialized_apps_desc
    assert_equal 'others_desc'.humanize.downcase, software.others_desc
  end
  
end
