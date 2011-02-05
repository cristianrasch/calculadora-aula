require 'test_helper'

class BudgetTest < ActiveSupport::TestCase
  
  test "downcase_attrs" do
    budget = Budget.new :name => 'My Budget', :description => "My budget's description"
    assert_difference 'Budget.count' do
      budget.save
    end
    assert_equal 'my budget', budget.name
    assert_equal "my budget's description", budget.description
  end

end
