require 'test_helper'

class GeneralSettingsTest < ActiveSupport::TestCase
  
  test "students_workstations_count_desc" do
    desc = @general_settings.students_workstations_count_desc
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  test "servers_count_desc" do
    desc = @general_settings.servers_count_desc
    assert desc.is_a? Array
    assert ! desc.empty?
  end
  
  protected
  
  def setup
    @general_settings = Factory :general_settings
  end
  
end
