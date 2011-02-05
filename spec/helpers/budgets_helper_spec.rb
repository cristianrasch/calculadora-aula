require 'spec_helper'

describe BudgetsHelper do
  
  before do
    generate_budget
  end
  
  it "should be able to be tableized" do
    table = helper.to_table @budget
    
    table[1][0].should match(/\w(\w|\s)+/)
    table[1][1].should_not be_blank
    table[1][2].should match(/\$\s(\d|.)+,\d+/)
    table[1][3].to_s.should match(/\d+/)
    table[1][4].should match(/\$\s(\d|.)+,\d+/)
  end
  
end