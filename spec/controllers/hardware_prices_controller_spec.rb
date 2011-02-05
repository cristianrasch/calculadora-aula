require 'spec_helper'

describe HardwarePricesController do
  render_views
  
  before do
    @budget = Factory :budget
  end
  
  context "new action" do
    it "should render an invalid new action" do
      get :new, :budget_id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      flash[:error] == Budget.model_name.human.humanize+" "+I18n.t('record_not_found') 
    end
    
    it "should render the new action" do
      get :new, :budget_id => @budget
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:hardware_prices].should_not be_nil
      assigns[:hardware_prices].budget_id.should == assigns[:budget].id
    end
  end
  
  context "create action" do
    it "should render an invalid create action" do
      post :create, :budget_id => @budget, 
           :hardware_prices => {:ram_unit_price => -1}
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:hardware_prices].should_not be_nil
      assigns[:hardware_prices].should be_new_record
    end
  
    it "should render the create action" do
      post :create, :budget_id => @budget,
           :hardware_prices => Factory.attributes_for(:hardware_prices)
  
      assigns[:budget].should_not be_nil
      assigns[:hardware_prices].should_not be_nil
      response.should be_redirect
      response.should redirect_to(budget_hardware_prices_path(assigns[:budget]))
      flash[:notice] == "#{HardwarePrices.model_name.human.humanize} #{I18n.t('msgs.saved').pluralize}"
    end
  end

  context "show action" do
      it "should render an invalid show action" do
      get :show, :budget_id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:budget].should be_nil
      flash[:error] == HardwarePrices.model_name.human.humanize+" "+I18n.t('msgs.record_not_found').pluralize
    end
  
    it "should render the show action" do
      hardware_prices = @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
      get :show, :budget_id => @budget
  
      response.should be_success
      response.should render_template('show')
      assigns[:budget].should_not be_nil
      assigns[:hardware_prices].should_not be_nil
      assigns[:hardware_prices].should == hardware_prices
    end
  end
  
  context "edit action" do
    it "should render an invalid edit action" do
      get :edit, :budget_id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:budget].should be_nil
      flash[:error].should == HardwarePrices.model_name.human.humanize+" "+I18n.t('msgs.record_not_found').pluralize
    end
  
    it "should render the edit action" do
      @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
      get :edit, :budget_id => @budget
  
      response.should be_success
      response.should render_template('edit')
      assigns[:budget].should_not be_nil
    end
  end
  
  context "update action" do
    it "should render an invalid update action" do
      @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
      @request.env["HTTP_REFERER"] = edit_budget_hardware_prices_path(@budget)
      put :update, :budget_id => @budget, :hardware_prices => {:ram_unit_price => -1}
  
      response.should be_redirect
      response.should redirect_to(edit_budget_hardware_prices_path(@budget))
      flash[:error].should_not be_nil
    end
  
    it "should render the update action" do
      @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
      put :update, :budget_id => @budget, :hardware_prices => {:ram_unit_price => 30}
  
      response.should be_redirect
      response.should redirect_to(budget_hardware_prices_path(@budget))
      assigns[:budget].should_not be_nil
      assigns[:budget].hardware_prices.ram_unit_price.should == 30
      flash[:notice] == "#{HardwarePrices.model_name.human.humanize} #{I18n.t('msgs.saved').pluralize}"
    end
  end

  it "should render the destroy action" do
    @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
    delete :destroy, :budget_id => @budget

    assigns[:budget].should_not be_nil
    assigns[:budget].reload
    assigns[:budget].hardware_prices.should be_nil
    response.should be_redirect
    response.should redirect_to(budget_path(@budget))
    flash[:notice].should == "#{HardwarePrices.model_name.human.humanize} #{I18n.t('msgs.deleted').pluralize}"
  end
  
end