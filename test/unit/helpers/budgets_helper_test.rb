require 'test_helper'

class BudgetsHelperTest < ActionView::TestCase
  
  test "to_table" do
    table = to_table @budget
    
    assert_match /\w(\w|\s)+/, table[1][0]
    assert ! table[1][1].blank?
    assert_match /\$\s(\d|.)+,\d+/, table[1][2]
    assert_match /\d+/, table[1][3].to_s
    assert_match /\$\s(\d|.)+,\d+/, table[1][4]
  end
  
  protected
  
  setup :generate_budget
  
end
