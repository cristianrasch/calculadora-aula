require 'test_helper'

class WorkstationsSettingsControllerTest < ActionController::TestCase

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
    get :new, :budget_id => @budget, :target => WorkstationsSettings::Target::STUDENTS

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:workstations_settings)
    assert_equal assigns(:budget).id, assigns(:workstations_settings).budget_id
  end

  test "create invalid" do
    post :create, :budget_id => @budget, :workstations_settings => {:ram_size_in_gigs => 0}

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:workstations_settings)
    assert assigns(:workstations_settings).new_record?
  end

  test "create" do
    post :create, :budget_id => @budget,
         :workstations_settings => Factory.attributes_for(:workstations_settings)

    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:workstations_settings)
    assert_response :redirect
   assert_redirected_to budget_workstations_settings_path(assigns(:budget), assigns(:workstations_settings))
    assert_equal "#{WorkstationsSettings.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end
  
  test "show-edit invalid" do
    get :show, :budget_id => @budget, :id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:workstations_settings)
    assert_equal WorkstationsSettings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
                 
    get :edit, :budget_id => @budget, :id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:workstations_settings)
    assert_equal WorkstationsSettings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
  end

  test "show" do
    workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
    get :show, :budget_id => @budget, :id => workstations_settings

    assert_response :ok
    assert_template 'show'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:workstations_settings)
    assert_equal workstations_settings, assigns(:workstations_settings)
  end

  test "edit" do
    workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
    get :edit, :budget_id => @budget, :id => workstations_settings

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:workstations_settings)
    assert_equal workstations_settings, assigns(:workstations_settings)
  end

  test "update invalid" do
    workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
    @request.env["HTTP_REFERER"] = edit_budget_workstations_settings_path(@budget, workstations_settings)
    put :update, :budget_id => @budget, :id => workstations_settings,
        :workstations_settings => {:ram_size_in_gigs => 0}

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:workstations_settings)
    assert ! assigns(:workstations_settings).valid?
  end

  test "update" do
    workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
    put :update, :budget_id => @budget, :id => workstations_settings,
        :workstations_settings => {:ram_size_in_gigs => 2}

    assert_not_nil assigns(:workstations_settings)
    assert_response :redirect
    assert_redirected_to budget_workstations_settings_path(@budget, assigns(:workstations_settings))    
    assert_equal 2, assigns(:workstations_settings).ram_size_in_gigs
    assert_equal "#{WorkstationsSettings.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end

  test "destroy" do
    workstations_settings = @budget.workstations_settings.create Factory.attributes_for(:workstations_settings)
    delete :destroy, :budget_id => @budget, :id => workstations_settings

    assert_not_nil assigns(:workstations_settings)
    @budget.reload
    assert_nil @budget.students_workstations_settings
    assert_response :redirect
    assert_redirected_to @budget
    assert_equal "#{WorkstationsSettings.model_name.human_name.humanize} #{I18n.t('msgs.deleted').pluralize}",
                 flash[:notice]
  end

  protected

  def setup
    @budget = Factory :budget
  end

end
