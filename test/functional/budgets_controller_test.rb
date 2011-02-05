require 'test_helper'

class BudgetsControllerTest < ActionController::TestCase
  
  test "index" do
    get :index
    
    assert_response :ok
    assert_template 'index'
    assert_not_nil assigns(:budgets)
  end
  
  test "new" do
    get :new
    
    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
  end
  
  test "create invalid" do
    post :create, :budget => {}
    
    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert assigns(:budget).new_record?
  end
  
  test "create" do
    post :create, :budget => Factory.attributes_for(:budget)
    
    assert_not_nil assigns(:budget)
    assert ! assigns(:budget).new_record?
    assert_response :redirect
    assert_redirected_to assigns(:budget)
    assert_equal "#{Budget.model_name.human_name.humanize} #{I18n.t 'msgs.saved'}", 
                 flash[:notice]
  end
  
  test "show invalid" do
    get :show, :id => 'xxx'
    
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_equal "#{Budget.model_name.human_name.humanize} #{I18n.t 'msgs.record_not_found'}", 
                 flash[:error]
  end
  
  test "show" do
    budget = Factory :budget
    get :show, :id => budget
    
    assert_response :ok
    assert_template 'show'
    assert_not_nil assigns(:budget)
    assert_equal budget, assigns(:budget)
  end
  
  test "edit" do
    budget = Factory :budget
    get :edit, :id => budget
    
    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:budget)
    assert_equal budget, assigns(:budget)
  end
  
  test "update invalid" do
    budget = Factory :budget
    put :update, :id => budget, :budget => {:name => 'xx'}
    
    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:budget).errors.on(:name)
  end
  
  test "update" do
    budget = Factory :budget
    put :update, :id => budget, :budget => {:name => 'xxx'}
    
    assert_not_nil assigns(:budget)
    assert assigns(:budget).errors.empty?
    assert_response :redirect
    assert_redirected_to assigns(:budget)
    assert_equal "#{Budget.model_name.human_name.humanize} #{I18n.t 'msgs.saved'}", 
                 flash[:notice]
  end
  
  test "destroy" do
    budget = Factory :budget
    delete :destroy, :id => budget
    
    assert_not_nil assigns(:budget)
    assert assigns(:budget).frozen?
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_equal "#{Budget.model_name.human_name.humanize} #{I18n.t 'msgs.deleted'}",
                 flash[:notice]
  end
  
  test "summarize" do
    generate_budget
    get :summarize, :id => @budget
    
    assert_response :ok
    assert_template 'summarize'
    assert_not_nil assigns(:budget)
    assert_equal @budget, assigns(:budget)
  end
  
end
