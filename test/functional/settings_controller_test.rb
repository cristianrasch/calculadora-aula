require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  
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
    assert_not_nil assigns(:settings)
    assert_equal assigns(:budget).id, assigns(:settings).budget_id
  end
  
  test "create invalid" do
    post :create, :budget_id => @budget, :settings => {:printers_count => -1}

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:settings)
    assert assigns(:settings).new_record?
  end

  test "create" do
    post :create, :budget_id => @budget,
         :settings => Factory.attributes_for(:settings)

    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:settings)
    assert_response :redirect
    assert_redirected_to budget_settings_path(assigns(:budget))
    assert_equal "#{Settings.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end
  
  test "show-edit invalid" do
    get :show, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:budget)
    assert_equal Settings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
                 
    get :edit, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:budget)
    assert_equal Settings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
  end

  test "show" do
    settings = @budget.create_settings Factory.attributes_for(:settings)
    get :show, :budget_id => @budget

    assert_response :ok
    assert_template 'show'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:settings)
    assert_equal settings, assigns(:settings)
  end

  test "edit" do
    @budget.create_settings Factory.attributes_for(:settings)
    get :edit, :budget_id => @budget

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:settings)
  end

  test "update invalid" do
    @budget.create_settings Factory.attributes_for(:settings)
    @request.env["HTTP_REFERER"] = edit_budget_settings_path(@budget)
    put :update, :budget_id => @budget, :settings => {:lan_enabled => nil}

    assert_response :redirect
    assert_redirected_to edit_budget_settings_path(@budget)
    assert_not_nil flash[:error]
  end

  test "update" do
    @budget.create_settings Factory.attributes_for(:settings)
    put :update, :budget_id => @budget, :settings => {:lan_enabled => false}

    assert_response :redirect
    assert_redirected_to budget_settings_path(@budget)
    assert_not_nil assigns(:budget)
    assert_equal false, assigns(:budget).settings.lan_enabled
    assert_equal "#{Settings.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end

  test "destroy" do
    @budget.create_settings Factory.attributes_for(:settings)
    delete :destroy, :budget_id => @budget

    assert_not_nil assigns(:budget)
    assigns(:budget).reload
    assert_nil assigns(:budget).settings
    assert_response :redirect
    assert_redirected_to @budget
    assert_equal "#{Settings.model_name.human_name.humanize} #{I18n.t('msgs.deleted').pluralize}",
                 flash[:notice]
  end

  protected

  def setup
    @budget = Factory :budget
  end

end
