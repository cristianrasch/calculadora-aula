require 'spec_helper'

describe Budget do
  
  it "should downcase its attrs before saving" do
    budget = Budget.new :name => 'My Budget', :description => "My budget's description"
    
    lambda {
      budget.save
    }.should change(Budget, :count).by(1)

    budget.name.should == 'my budget' 
    budget.description.should == "my budget's description" 
  end
  
end