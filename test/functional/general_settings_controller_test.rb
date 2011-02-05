require 'test_helper'

class GeneralSettingsControllerTest < ActionController::TestCase
  
  test "new invalid" do
    get :new, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_equal Budget.model_name.human_name.humanize+" "+I18n.t('record_not_found'), 
                 flash[:error]
  end
  
  test "new" do
    get :new, :budget_id => @budget

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:general_settings)
    assert_equal assigns(:budget).id, assigns(:general_settings).budget_id
  end
  
  test "create invalid" do
    post :create, :budget_id => @budget, :general_settings => {:students_count => 0}

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:general_settings)
    assert assigns(:general_settings).new_record?
  end

  test "create" do
    post :create, :budget_id => @budget,
         :general_settings => Factory.attributes_for(:general_settings)

    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:general_settings)
    assert_response :redirect
    assert_redirected_to budget_general_settings_path(assigns(:budget))
    assert_equal "#{GeneralSettings.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end

  test "show-edit invalid" do
    get :show, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:budget)
    assert_equal GeneralSettings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
                 
    get :edit, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:budget)
    assert_equal GeneralSettings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
  end

  test "show" do
    general_settings = @budget.create_general_settings Factory.attributes_for(:general_settings)
    get :show, :budget_id => @budget

    assert_response :ok
    assert_template 'show'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:general_settings)
    assert_equal general_settings, assigns(:general_settings)
  end

  test "edit" do
    @budget.create_general_settings Factory.attributes_for(:general_settings)
    get :edit, :budget_id => @budget

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:budget)
  end

  test "update invalid" do
    @budget.create_general_settings Factory.attributes_for(:general_settings)
    @request.env["HTTP_REFERER"] = edit_budget_general_settings_path(@budget)
    put :update, :budget_id => @budget, :general_settings => {:students_count => 0}

    assert_response :redirect
    assert_redirected_to edit_budget_general_settings_path(@budget)
    assert_not_nil flash[:error]
  end

  test "update" do
    @budget.create_general_settings Factory.attributes_for(:general_settings)
    put :update, :budget_id => @budget, :general_settings => {:teachers_count => 2}

    assert_response :redirect
    assert_redirected_to budget_general_settings_path(@budget)
    assert_not_nil assigns(:budget)
    assert_equal 2, assigns(:budget).general_settings.teachers_count
    assert_equal "#{GeneralSettings.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end

  test "destroy" do
    @budget.create_general_settings Factory.attributes_for(:general_settings)
    delete :destroy, :budget_id => @budget

    assert_not_nil assigns(:budget)
    assigns(:budget).reload
    assert_nil assigns(:budget).general_settings
    assert_response :redirect
    assert_redirected_to @budget
    assert_equal "#{GeneralSettings.model_name.human_name.humanize} #{I18n.t('msgs.deleted').pluralize}",
                 flash[:notice]
  end

  protected

  def setup
    @budget = Factory :budget
  end

end
