require 'test_helper'

class SoftwareControllerTest < ActionController::TestCase
  
  test "index-new invalid" do
    get :index
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_equal Budget.model_name.human_name.humanize+" "+I18n.t('record_not_found'), 
                 flash[:error]
                 
    get :new, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_equal Budget.model_name.human_name.humanize+" "+I18n.t('record_not_found'), 
                 flash[:error]
  end
  
  test "index" do
    get :index, :budget_id => @budget

    assert_response :ok
    assert_template 'index'
    assert_not_nil assigns(:budget)
    assert_equal @budget, assigns(:budget)
  end

  test "new" do
    get :new, :budget_id => @budget, 
        :target => Software::Target::STUDENTS_STANDALONE

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:software)
    assert_equal assigns(:budget).id, assigns(:software).budget_id
  end

  test "create invalid" do
    post :create, :budget_id => @budget, 
         :software => {:target => Software::Target::STUDENTS_STANDALONE,
                      :os => -1}

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:software)
    assert assigns(:software).new_record?
  end

  test "create" do
    post :create, :budget_id => @budget,
         :software => Factory.attributes_for(:software)

    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:software)
    assert_response :redirect
    assert_redirected_to budget_software_path(assigns(:budget), assigns(:software))
    assert_equal "#{Software.model_name.human_name.humanize} #{I18n.t('msgs.saved')}",
                 flash[:notice]
  end
  
  test "show-edit invalid" do
    get :show, :budget_id => @budget, :id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:software)
    assert_equal Software.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found'),
                 flash[:error]
                 
    get :edit, :budget_id => @budget, :id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:software)
    assert_equal Software.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found'),
                 flash[:error]
  end

  test "show" do
    software = @budget.software.create Factory.attributes_for(:software)
    get :show, :budget_id => @budget, :id => software

    assert_response :ok
    assert_template 'show'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:software)
    assert_equal software, assigns(:software)
  end

  test "edit" do
    software = @budget.software.create Factory.attributes_for(:software)
    get :edit, :budget_id => @budget, :id => software

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:software)
    assert_equal software, assigns(:software)
  end

  test "update invalid" do
    software = @budget.software.create Factory.attributes_for(:software)
    @request.env["HTTP_REFERER"] = edit_budget_software_path(@budget, software)
    put :update, :budget_id => @budget, :id => software,
        :software => {:os => -1}

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:software)
    assert ! assigns(:software).valid?
  end

  test "update" do
    software = @budget.software.create Factory.attributes_for(:software)
    put :update, :budget_id => @budget, :id => software,
        :software => {:os => 56.78}

    assert_not_nil assigns(:software)
    assert_response :redirect
    assert_redirected_to budget_software_path(@budget, assigns(:software))
    assert_equal 56.78, assigns(:software).os
    assert_equal "#{Software.model_name.human_name.humanize} #{I18n.t('msgs.saved')}",
                 flash[:notice]
  end

  test "destroy" do
    software = @budget.software.create Factory.attributes_for(:software)
    delete :destroy, :budget_id => @budget, :id => software

    assert_not_nil assigns(:software)
    @budget.reload
    assert_nil @budget.students_standalone_software
    assert_response :redirect
    assert_redirected_to @budget
    assert_equal "#{Software.model_name.human_name.humanize} #{I18n.t('msgs.deleted')}",
                 flash[:notice]
  end

  protected

  def setup
    @budget = Factory :budget
  end
  
end
