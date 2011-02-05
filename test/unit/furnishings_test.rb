require 'test_helper'

class FurnishingsTest < ActiveSupport::TestCase
  
  test "*_cost" do
    assert_not_nil @furnishings.chairs_cost
    assert_not_nil @furnishings.tables_cost
    assert_not_nil @furnishings.others_cost
    assert_equal @furnishings.chairs_cost + @furnishings.tables_cost + @furnishings.others_cost,
                 @furnishings.total_cost
  end

  test "downcase_attrs" do
    assert_equal 'chair_unit_price_desc'.humanize.downcase, @furnishings.chair_unit_price_desc
    assert_equal 'table_unit_price_desc'.humanize.downcase, @furnishings.table_unit_price_desc
    assert_equal 'others_unit_price_desc'.humanize.downcase, @furnishings.others_unit_price_desc
  end
  
  protected
  
  def setup
    @furnishings = Factory :furnishings, :chair_unit_price_desc => 'chair_unit_price_desc'.titleize,
                           :table_unit_price_desc => 'table_unit_price_desc'.titleize,
                           :others_unit_price_desc => 'others_unit_price_desc'.titleize
  end

end
