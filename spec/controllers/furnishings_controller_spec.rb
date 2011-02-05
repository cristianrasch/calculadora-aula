require 'spec_helper'

describe FurnishingsController do
  render_views
  
  before do
    @budget = Factory :budget
  end
  
#  context "index action" do
#    it "should render an invalid index action" do
#      get :index
#      response.should be_redirect
#      response.should redirect_to(budgets_path)
#      flash[:error].should == Budget.model_name.human.humanize+" "+I18n.t('record_not_found') 
#    end
#    
#    it "should render the index action" do
#      get :index, :budget_id => @budget
#  
#      response.should be_success
#      response.should render_template('index')
#      assigns[:budget].should_not be_nil
#      assigns[:budget].should == @budget
#    end
#  end
  
  context "new action" do
    it "should render an invalid new action" do
      get :new, :budget_id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      flash[:error].should == Budget.model_name.human.humanize+" "+I18n.t('record_not_found') 
    end
    
    it "should render the new action" do
      get :new, :budget_id => @budget, 
          :target => Furnishings::Target::STUDENTS
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:furnishings].should_not be_nil
      assigns[:furnishings].budget_id.should == assigns[:budget].id
    end
  end

  context "create action" do
    it "should render an invalid create action" do
      post :create, :budget_id => @budget, 
           :furnishings => {:chairs_unit_price => 0}
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:furnishings].should_not be_nil
      assigns[:furnishings].should be_a_new_record
    end
  
    it "should render the create" do
      post :create, :budget_id => @budget,
           :furnishings => Factory.attributes_for(:furnishings)
  
      assigns[:budget].should_not be_nil
      assigns[:furnishings].should_not be_nil
      response.should be_redirect
      response.should redirect_to(budget_furnishings_path(assigns[:budget], assigns[:furnishings]))
      flash[:notice].should == "#{Furnishings.model_name.human.humanize} #{I18n.t('msgs.saved')}"
    end
  end

  context "show action" do
    it "should render an invalid show action" do
      get :show, :budget_id => @budget, :id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:furnishings].should be_nil
      flash[:error].should == Furnishings.model_name.human.humanize+" "+I18n.t('msgs.record_not_found')
    end
  
    it "should render the show action" do
      furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
      get :show, :budget_id => @budget, :id => furnishings
  
      response.should be_success
      response.should render_template('show')
      assigns[:budget].should_not be_nil
      assigns[:furnishings].should_not be_nil
      assigns[:furnishings].should == furnishings 
    end
  end

  context "edit action" do
    it "should render an invalid edit action" do
      get :edit, :budget_id => @budget, :id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:furnishings].should be_nil
      flash[:error].should == Furnishings.model_name.human.humanize+" "+I18n.t('msgs.record_not_found')
    end
  
    it "should render the edit action" do
      furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
      get :edit, :budget_id => @budget, :id => furnishings
  
      response.should be_success
      response.should render_template('edit')
      assigns[:budget].should_not be_nil
      assigns[:furnishings].should_not be_nil
      assigns[:furnishings].should == furnishings
    end
  end


  context "update action" do
    it "should render an invalid update action" do
      furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
      @request.env["HTTP_REFERER"] = edit_budget_furnishings_path(@budget, furnishings)
      put :update, :budget_id => @budget, :id => furnishings,
          :furnishings => {:chairs_unit_price => 0}
  
      response.should be_success
      response.should render_template('edit')
      assigns[:furnishings].should_not be_nil
      assigns[:furnishings].should_not be_valid
    end
  
    it "should render the update action" do
      furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
      put :update, :budget_id => @budget, :id => furnishings,
          :furnishings => {:chairs_unit_price => 56.78}
  
      assigns[:furnishings].should_not be_nil
      response.should be_redirect
      response.should redirect_to(budget_furnishings_path(@budget, assigns[:furnishings]))
      assigns[:furnishings].chairs_unit_price.should == 56.78
      flash[:notice].should == "#{Furnishings.model_name.human.humanize} #{I18n.t('msgs.saved')}"
    end
  end
  

  it "should render the destroy action" do
    furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
    delete :destroy, :budget_id => @budget, :id => furnishings

    assigns[:furnishings].should_not be_nil
    @budget.reload
    @budget.students_furnishings.should be_nil
    response.should be_redirect
    response.should redirect_to(budget_path(@budget))
    flash[:notice].should == "#{Furnishings.model_name.human.humanize} #{I18n.t('msgs.deleted')}"
  end

end