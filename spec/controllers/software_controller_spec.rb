require 'spec_helper'

describe SoftwareController do
  render_views
  
  before do
    @budget = Factory :budget
  end
  
#  context "index action" do
#    it "should render an invalid index action" do
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
      get :new, :budget_id => @budget, 
          :target => Software::Target::STUDENTS_STANDALONE
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:software].should_not be_nil
      assigns[:software].budget_id.should == assigns[:budget].id
    end
  end
  
  context "create action" do
    it "should render an invalid create action" do
      post :create, :budget_id => @budget, 
           :software => {:target => Software::Target::STUDENTS_STANDALONE,
                        :os_unit_price => -1}
  
      response.should be_success
      response.should render_template('new')
      assigns[:budget].should_not be_nil
      assigns[:software].should_not be_nil
      assigns[:software].should be_new_record
    end
  
    it "should render the create action" do
      post :create, :budget_id => @budget,
           :software => Factory.attributes_for(:software)
  
      assigns[:budget].should_not be_nil
      assigns[:software].should_not be_nil
      response.should be_redirect
      response.should redirect_to(budget_software_path(assigns[:budget], assigns[:software]))
      flash[:notice].should == "#{Software.model_name.human.humanize} #{I18n.t('msgs.saved')}"
    end
  end

  context "show action" do
    it "should render an invalid show action" do
      get :show, :budget_id => @budget, :id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:software].should be_nil
      flash[:error].should == Software.model_name.human.humanize+" "+I18n.t('msgs.record_not_found')
    end
  
    it "should render the show action" do
      software = @budget.software.create Factory.attributes_for(:software)
      get :show, :budget_id => @budget, :id => software
  
      response.should be_success
      response.should render_template('show')
      assigns[:budget].should_not be_nil
      assigns[:software].should_not be_nil
      assigns[:software].should == software
    end
  end
  
  context "edit action" do
    it "should render an invalid edit action" do
      get :edit, :budget_id => @budget, :id => 0
      
      response.should be_redirect
      response.should redirect_to(budgets_path)
      assigns[:software].should be_nil
      flash[:error].should == Software.model_name.human.humanize+" "+I18n.t('msgs.record_not_found')
    end
  
    it "should render the edit action" do
      software = @budget.software.create Factory.attributes_for(:software)
      get :edit, :budget_id => @budget, :id => software
  
      response.should be_success
      response.should render_template('edit')
      assigns[:budget].should_not be_nil
      assigns[:software].should_not be_nil
      assigns[:software].should == software
    end
  end

  context "update action" do
    it "should render an invalid update action" do
      software = @budget.software.create Factory.attributes_for(:software)
      @request.env["HTTP_REFERER"] = edit_budget_software_path(@budget, software)
      put :update, :budget_id => @budget, :id => software,
          :software => {:os_unit_price => -1}
  
      response.should be_success
      response.should render_template('edit')
      assigns[:software].should_not be_nil
      assigns[:software].should_not be_valid
    end
  
    it "should render the update action" do
      software = @budget.software.create Factory.attributes_for(:software)
      put :update, :budget_id => @budget, :id => software,
          :software => {:os_unit_price => 56.78}
  
      assigns[:software].should_not be_nil
      response.should be_redirect
      response.should redirect_to(budget_software_path(@budget, assigns[:software]))
      assigns[:software].os_unit_price.should == 56.78
      flash[:notice].should == "#{Software.model_name.human.humanize} #{I18n.t('msgs.saved')}"
    end
  end


  it "should render the destroy action" do
    software = @budget.software.create Factory.attributes_for(:software)
    delete :destroy, :budget_id => @budget, :id => software

    assigns[:software].should_not be_nil
    @budget.reload
    @budget.students_standalone_software.should be_nil
    response.should be_redirect
    response.should redirect_to(budget_path(@budget))
    flash[:notice].should == "#{Software.model_name.human.humanize} #{I18n.t('msgs.deleted')}"
  end
  
end