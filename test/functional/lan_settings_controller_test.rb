require 'test_helper'

class LanSettingsControllerTest < ActionController::TestCase

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
    assert_not_nil assigns(:lan_settings)
    assert_equal assigns(:budget).id, assigns(:lan_settings).budget_id
  end

  test "create invalid" do
    post :create, :budget_id => @budget, :lan_settings => {:ports_per_switch => 0}

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:lan_settings)
    assert assigns(:lan_settings).new_record?
  end

  test "create" do
    post :create, :budget_id => @budget,
         :lan_settings => Factory.attributes_for(:lan_settings)

    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:lan_settings)
    assert_response :redirect
    assert_redirected_to budget_lan_settings_path(assigns(:budget))
    assert_equal "#{LanSettings.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end
  
  test "show-edit invalid" do
    get :show, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:budget)
    assert_equal LanSettings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
                 
    get :edit, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:budget)
    assert_equal LanSettings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
  end

  test "show" do
    lan_settings = @budget.create_lan_settings Factory.attributes_for(:lan_settings)
    get :show, :budget_id => @budget

    assert_response :ok
    assert_template 'show'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:lan_settings)
    assert_equal lan_settings, assigns(:lan_settings)
  end

  test "edit" do
    @budget.create_lan_settings Factory.attributes_for(:lan_settings)
    get :edit, :budget_id => @budget

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:budget)
  end

  test "update invalid" do
    @budget.create_lan_settings Factory.attributes_for(:lan_settings)
    @request.env["HTTP_REFERER"] = edit_budget_lan_settings_path(@budget)
    put :update, :budget_id => @budget, :lan_settings => {:ports_per_switch => 0}

    assert_response :redirect
    assert_redirected_to edit_budget_lan_settings_path(@budget)
    assert_not_nil flash[:error]
  end

  test "update" do
    @budget.create_lan_settings Factory.attributes_for(:lan_settings)
    put :update, :budget_id => @budget,
        :lan_settings => {:medium_distance_bt_pcs_switch => 7.8}

    assert_response :redirect
    assert_redirected_to budget_lan_settings_path(@budget)
    assert_not_nil assigns(:budget)
    assert_equal 7.8, assigns(:budget).lan_settings.medium_distance_bt_pcs_switch
    assert_equal "#{LanSettings.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end

  test "destroy" do
    @budget.create_lan_settings Factory.attributes_for(:lan_settings)
    delete :destroy, :budget_id => @budget

    assert_not_nil assigns(:budget)
    assigns(:budget).reload
    assert_nil assigns(:budget).lan_settings
    assert_response :redirect
    assert_redirected_to @budget
    assert_equal "#{LanSettings.model_name.human_name.humanize} #{I18n.t('msgs.deleted').pluralize}",
                 flash[:notice]
  end

  protected

  def setup
    @budget = Factory :budget
  end

end
