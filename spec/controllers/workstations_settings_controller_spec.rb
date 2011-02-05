require 'spec_helper'

describe WorkstationsSettingsController do
  render_views
  
  before do
    @budget = Factory :budget
  end
  
#  context "index action" do
#    it "should render the index-new invalid action" do
#      get :index
#      
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
      get :new, :budget_id => @budget, :target => WorkstationsSettings::Target::STUDENTS
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:workstations_settings].should_not be_nil
      assigns[:workstations_settings].budget_id.should == assigns[:budget].id
    end
  end
  
  context "create action" do
    it "should render an invalid create action" do
      post :create, :budget_id => @budget, 
           :workstations_settings => {:ram_size_in_gigs => 0}
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:workstations_settings].should_not be_nil
      assigns[:workstations_settings].should be_new_record
    end
  
    it "should render the create action" do
      post :create, :budget_id => @budget,
           :workstations_settings => Factory.attributes_for(:workstations_settings)
  
      assigns[:budget].should_not be_nil
      assigns[:workstations_settings].should_not be_nil
      response.should be_redirect
      response.should redirect_to(budget_workstations_settings_path(assigns[:budget], assigns[:workstations_settings]))
      flash[:notice].should == "#{WorkstationsSettings.model_name.human.humanize} #{I18n.t('msgs.saved').pluralize}"
    end
  end

  context "show action" do
    it "should render an invalid show action" do
      get :show, :budget_id => @budget, :id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:workstations_settings].should be_nil
      flash[:error].should == WorkstationsSettings.model_name.human.humanize+" "+I18n.t('msgs.record_not_found').pluralize
    end
  
    it "should render the show action" do
      @budget.hardware_prices = Factory.build :hardware_prices
      workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
      get :show, :budget_id => @budget, :id => workstations_settings
  
      response.should be_success
      response.should render_template('show')
      assigns[:budget].should_not be_nil
      assigns[:workstations_settings].should_not be_nil
      assigns[:workstations_settings].should == workstations_settings
    end
  end
  
  context "edit action" do
    it "should render an invalid edit action" do
      get :edit, :budget_id => @budget, :id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:workstations_settings].should be_nil
      flash[:error].should == WorkstationsSettings.model_name.human.humanize+" "+I18n.t('msgs.record_not_found').pluralize
    end
  
    it "should render the edit action" do
      workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
      get :edit, :budget_id => @budget, :id => workstations_settings
  
      response.should be_success
      response.should render_template('edit')
      assigns[:budget].should_not be_nil
      assigns[:workstations_settings].should_not be_nil
      assigns[:workstations_settings].should == workstations_settings
    end
  end
  
  context "update action" do
    it "should render an invalid update action" do
      workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
      @request.env["HTTP_REFERER"] = edit_budget_workstations_settings_path(@budget, workstations_settings)
      put :update, :budget_id => @budget, :id => workstations_settings,
          :workstations_settings => {:ram_size_in_gigs => 0}
  
      response.should be_success
      response.should render_template('edit')
      assigns[:workstations_settings].should_not be_nil
      assigns[:workstations_settings].should_not be_valid
    end
  
    it "should render the update action" do
      workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
      put :update, :budget_id => @budget, :id => workstations_settings,
          :workstations_settings => {:ram_size_in_gigs => 2}
  
      assigns[:workstations_settings].should_not be_nil
      response.should be_redirect
      response.should redirect_to(budget_workstations_settings_path(@budget, assigns[:workstations_settings]))    
      assigns[:workstations_settings].ram_size_in_gigs.should == 2
      flash[:notice].should == "#{WorkstationsSettings.model_name.human.humanize} #{I18n.t('msgs.saved').pluralize}"
    end
  end


  it "should render the destroy action" do
    workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
    delete :destroy, :budget_id => @budget, :id => workstations_settings

    assigns[:workstations_settings].should_not be_nil
    @budget.reload
    @budget.students_workstations_settings.should be_nil
    response.should be_redirect
    response.should redirect_to(budget_path(@budget))
    flash[:notice].should == "#{WorkstationsSettings.model_name.human.humanize} #{I18n.t('msgs.deleted').pluralize}"
  end
  
end