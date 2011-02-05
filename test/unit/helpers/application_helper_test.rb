require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  test "model_not_found" do
    msg = model_not_found Budget
    assert_match /#{I18n.t('msgs.not_found')}/, msg
    assert_match /presupuestos/i, msg
  end
  
  test "yes_no_select" do
    sel = yes_no_select('parent', 'child_id', :include_blank => true).to_s
    assert_match /parent[child_id]/, sel
    assert_match /option value=""/, sel
    assert_match /<option value="0">no<\/option>/i, sel
  end
  
  test "yes_no" do
    assert_equal 'No', yes_no(false)
  end
  
  test "strong" do
    assert_match /<strong>\w+<\/strong>/, strong('xxx')
  end
  
  test "em" do
    assert_match /<em>\w+<\/em>/, em('xxx')
  end
  
  test "total_cost_desc" do
    msg = total_cost_desc %w{ab cd efg}, '-'
    assert_match /<em>\((\w|\s|-)+\)<\/em>/, msg
  end
  
  test "remove_zeros" do
    assert_equal 1, remove_zeros([[1, 2],[3, 0]]).length
    assert_equal 1, remove_zeros([[1, 'xxx $ 0,00'],[3, 0.55]]).length
    assert_equal 2, remove_zeros([[1, 2.34],[3, 'any value..']]).length
  end
  
end
