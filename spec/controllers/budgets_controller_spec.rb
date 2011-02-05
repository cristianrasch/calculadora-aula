require 'spec_helper'

describe BudgetsController do
  render_views
  
  it "should render the index action" do
    get :index
    
    response.should be_success
    response.should render_template('index')
    assigns[:budgets].should_not be_nil
  end
  
  it "should render the new action" do
    get :new
    
    response.should be_success
    response.should render_template('new')
    assigns[:budget].should_not be_nil
  end
  
  context "create action" do
    it "should render an invalid create action" do
      post :create, :budget => {}
      
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:budget].should be_a_new_record
    end
    
    it "should render the create action" do
      post :create, :budget => Factory.attributes_for(:budget)
      
      assigns[:budget].should_not be_nil
      assigns[:budget].should_not be_a_new_record
      response.should be_redirect
      response.should redirect_to(budget_path(assigns[:budget]))
      flash[:notice].should == "#{Budget.model_name.human.humanize} #{I18n.t 'msgs.saved'}" 
    end
  end
  
  context "show action" do
    it "should render an invalid show action" do
      get :show, :id => 'xxx'
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      flash[:error].should == "#{Budget.model_name.human.humanize} #{I18n.t 'msgs.record_not_found'}" 
    end
    
    it "should render the show action" do
      budget = Factory :budget
      get :show, :id => budget
      
      response.should be_success
      response.should render_template('show')
      assigns[:budget].should_not be_nil
      assigns[:budget].should == budget
    end
  end
  
  context "edit action" do
    it "should render an edit summarize action" do
      get :edit, :id => 'xxx'
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      flash[:error].should == "#{Budget.model_name.human.humanize} #{I18n.t 'msgs.record_not_found'}"
      assigns(:budget).should be_nil
    end
    
    it "should render the edit action" do
      budget = Factory :budget
      get :edit, :id => budget
      
      response.should be_success
      response.should render_template('edit')
      assigns[:budget].should_not be_nil
      assigns[:budget].should == budget
    end
  end
  
  
  context "update action" do
    it "should render an invalid update action" do
      budget = Factory :budget
      put :update, :id => budget, :budget => {:name => 'xx'}
      
      response.should be_success
      response.should render_template('edit')
      assigns[:budget].should_not be_nil
      assigns[:budget].should have(1).error_on(:name)
    end
    
    it "should render the update action" do
      budget = Factory :budget
      put :update, :id => budget, :budget => {:name => 'xxx'}
      
      assigns[:budget].should_not be_nil
      assigns[:budget].should have(:no).errors
      response.should be_redirect
      response.should redirect_to(budget_path(assigns[:budget]))
      flash[:notice].should == "#{Budget.model_name.human.humanize} #{I18n.t 'msgs.saved'}" 
    end
  end
  
  it "should render the destroy action" do
    budget = Factory :budget
    delete :destroy, :id => budget
    
    assigns[:budget].should_not be_nil
    assigns[:budget].should be_frozen
    response.should be_redirect
    response.should redirect_to(budgets_path)
    flash[:notice].should == "#{Budget.model_name.human.humanize} #{I18n.t 'msgs.deleted'}"
  end
  
  context "summarize action" do
    it "should render an invalid summarize action" do
      get :summarize, :id => 'xxx'
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      flash[:error].should == "#{Budget.model_name.human.humanize} #{I18n.t 'msgs.record_not_found'}"
      assigns(:budget).should be_nil
    end
    
    it "should render the summarize action" do
      generate_budget
      get :summarize, :id => @budget
      
      response.should be_success
      response.should render_template('summarize')
      assigns(:budget).should_not be_nil
      assigns(:budget).should == @budget
    end
  end
  
end