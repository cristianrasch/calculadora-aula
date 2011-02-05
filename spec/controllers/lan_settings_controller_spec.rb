require 'spec_helper'

describe LanSettingsController do
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
      assigns[:lan_settings].should_not be_nil
      assigns[:lan_settings].budget_id.should == assigns[:budget].id
    end
  end
  
  context "create action" do
    it "should render an invalid create action" do
      post :create, :budget_id => @budget, 
           :lan_settings => {:ports_per_switch => 0}
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:lan_settings].should_not be_nil
      assigns[:lan_settings].should be_new_record
    end
  
    it "should render the create action" do
      post :create, :budget_id => @budget,
           :lan_settings => Factory.attributes_for(:lan_settings)
  
      assigns[:budget].should_not be_nil
      assigns[:lan_settings].should_not be_nil
      response.should be_redirect
      response.should redirect_to(budget_lan_settings_path(assigns[:budget]))
      flash[:notice].should == "#{LanSettings.model_name.human.humanize} #{I18n.t('msgs.saved').pluralize}"
    end
  end

  context "show action" do
    it "should render an invalid show action" do
      get :show, :budget_id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:budget].should be_nil
      flash[:error].should == LanSettings.model_name.human.humanize+" "+I18n.t('msgs.record_not_found').pluralize
    end
  
    it "should render the show action" do
      lan_settings = @budget.create_lan_settings Factory.attributes_for(:lan_settings)
      get :show, :budget_id => @budget
  
      response.should be_success
      response.should render_template('show')
      assigns[:budget].should_not be_nil
      assigns[:lan_settings].should_not be_nil
      assigns[:lan_settings].should == lan_settings
    end
  end
  
  context "edit action" do
    it "should render an invalid edit action" do
      get :edit, :budget_id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:budget].should be_nil
      flash[:error].should == LanSettings.model_name.human.humanize+" "+I18n.t('msgs.record_not_found').pluralize
    end
  
    it "should render the edit action" do
      @budget.create_lan_settings Factory.attributes_for(:lan_settings)
      get :edit, :budget_id => @budget
  
      response.should be_success
      response.should render_template('edit')
      assigns[:budget].should_not be_nil
    end
  end
  
  context "update action" do
    it "should render an invalid update action" do
      @budget.create_lan_settings Factory.attributes_for(:lan_settings)
      @request.env["HTTP_REFERER"] = edit_budget_lan_settings_path(@budget)
      put :update, :budget_id => @budget, :lan_settings => {:ports_per_switch => 0}
  
      response.should be_redirect
      response.should redirect_to(edit_budget_lan_settings_path(@budget))
      flash[:error].should_not be_nil
    end
  
    it "should render the update action" do
      @budget.create_lan_settings Factory.attributes_for(:lan_settings)
      put :update, :budget_id => @budget,
          :lan_settings => {:medium_distance_bt_pcs_switch => 7.8}
  
      response.should be_redirect
      response.should redirect_to(budget_lan_settings_path(@budget))
      assigns[:budget].should_not be_nil
      assigns[:budget].lan_settings.medium_distance_bt_pcs_switch.should == 7.8
      flash[:notice].should == "#{LanSettings.model_name.human.humanize} #{I18n.t('msgs.saved').pluralize}"
    end
  end

  it "should render the destroy action" do
    @budget.create_lan_settings Factory.attributes_for(:lan_settings)
    delete :destroy, :budget_id => @budget

    assigns[:budget].should_not be_nil
    assigns(:budget).reload
    assigns[:budget].lan_settings.should be_nil
    response.should be_redirect
    response.should redirect_to(budget_path(@budget))
    flash[:notice].should == "#{LanSettings.model_name.human.humanize} #{I18n.t('msgs.deleted').pluralize}"
  end
  
end