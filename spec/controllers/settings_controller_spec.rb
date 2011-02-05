require 'spec_helper'

describe SettingsController do
  render_views
  
  before do
    @budget = Factory :budget
  end
  
  context "new action" do
    it "should render an invalid new action" do
      get :new, :budget_id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      flash[:error].should == Budget.model_name.human.humanize+" "+I18n.t('record_not_found') 
    end
    
    it "should render the new action" do
      get :new, :budget_id => @budget
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:settings].should_not be_nil
      assigns[:settings].budget_id.should == assigns[:budget].id
    end
  end
  
  context "create action" do
    it "should render an invalid create action" do
      post :create, :budget_id => @budget, 
           :settings => {:printers_count => -1}
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:settings].should_not be_nil
      assigns[:settings].should be_new_record
    end
  
    it "should render the create action" do
      post :create, :budget_id => @budget,
           :settings => Factory.attributes_for(:settings)
  
      assigns[:budget].should_not be_nil
      assigns[:settings].should_not be_nil
      response.should be_redirect
      response.should redirect_to(budget_settings_path(assigns[:budget]))
      flash[:notice].should == "#{Settings.model_name.human.humanize} #{I18n.t('msgs.saved').pluralize}"
    end
  end
  
  context "show action" do
    it "should render an invalid show action" do
      get :show, :budget_id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:budget].should be_nil
      flash[:error].should == Settings.model_name.human.humanize+" "+I18n.t('msgs.record_not_found').pluralize
    end
  
    it "should render the show action" do
      settings = @budget.create_settings Factory.attributes_for(:settings)
      get :show, :budget_id => @budget
  
      response.should be_success
      response.should render_template('show')
      assigns[:budget].should_not be_nil
      assigns[:settings].should_not be_nil
      assigns[:settings].should == settings
    end
  end
  
  context "edit action" do
    it "should render an invalid edit action" do
      get :edit, :budget_id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:budget].should be_nil
      flash[:error].should == Settings.model_name.human.humanize+" "+I18n.t('msgs.record_not_found').pluralize
    end

    it "should render the edit action" do
      @budget.create_settings Factory.attributes_for(:settings)
      get :edit, :budget_id => @budget
  
      response.should be_success
      response.should render_template('edit')
      assigns[:budget].should_not be_nil
      assigns[:settings].should_not be_nil
    end
  end
  
  context "update action" do
    it "should render the update invalid action" do
      @budget.create_settings Factory.attributes_for(:settings)
      @request.env["HTTP_REFERER"] = edit_budget_settings_path(@budget)
      put :update, :budget_id => @budget, :settings => {:lan_enabled => nil}
  
      response.should be_redirect
      response.should redirect_to(edit_budget_settings_path(@budget))
      flash[:error].should_not be_nil
    end
  
    it "should render the update action" do
      @budget.create_settings Factory.attributes_for(:settings)
      put :update, :budget_id => @budget, :settings => {:lan_enabled => false}
  
      response.should be_redirect
      response.should redirect_to(budget_settings_path(@budget))
      assigns[:budget].should_not be_nil
      assigns[:budget].settings.should_not be_lan_enabled
      flash[:notice].should == "#{Settings.model_name.human.humanize} #{I18n.t('msgs.saved').pluralize}"
    end
  end

  it "should render the destroy action" do
    @budget.create_settings Factory.attributes_for(:settings)
    delete :destroy, :budget_id => @budget

    assigns[:budget].should_not be_nil
    assigns[:budget].reload
    assigns[:budget].settings.should be_nil
    response.should be_redirect
    response.should redirect_to(budget_path(@budget))
    flash[:notice].should == "#{Settings.model_name.human.humanize} #{I18n.t('msgs.deleted').pluralize}"
  end
  
end