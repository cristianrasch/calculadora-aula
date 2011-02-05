require 'test_helper'

class FurnishingsControllerTest < ActionController::TestCase

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
    get :new, :budget_id => @budget, :target => Furnishings::Target::STUDENTS

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:furnishings)
    assert_equal assigns(:budget).id, assigns(:furnishings).budget_id
  end

  test "create invalid" do
    post :create, :budget_id => @budget, :furnishings => {:chair_unit_price => 0}

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:furnishings)
    assert assigns(:furnishings).new_record?
  end

  test "create" do
    post :create, :budget_id => @budget,
         :furnishings => Factory.attributes_for(:furnishings)

    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:furnishings)
    assert_response :redirect
    assert_redirected_to budget_furnishings_path(assigns(:budget), assigns(:furnishings))
    assert_equal "#{Furnishings.model_name.human_name.humanize} #{I18n.t('msgs.saved')}",
                 flash[:notice]
  end
  
  test "show-edit invalid" do
    get :show, :budget_id => @budget, :id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:furnishings)
    assert_equal Furnishings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found'),
                 flash[:error]
                 
    get :edit, :budget_id => @budget, :id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:furnishings)
    assert_equal Furnishings.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found'),
                 flash[:error]
  end

  test "show" do
    furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
    get :show, :budget_id => @budget, :id => furnishings

    assert_response :ok
    assert_template 'show'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:furnishings)
    assert_equal furnishings, assigns(:furnishings)
  end

  test "edit" do
    furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
    get :edit, :budget_id => @budget, :id => furnishings

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:furnishings)
    assert_equal furnishings, assigns(:furnishings)
  end

  test "update invalid" do
    furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
    @request.env["HTTP_REFERER"] = edit_budget_furnishings_path(@budget, furnishings)
    put :update, :budget_id => @budget, :id => furnishings,
        :furnishings => {:chair_unit_price => 0}

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:furnishings)
    assert ! assigns(:furnishings).valid?
  end

  test "update" do
    furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
    put :update, :budget_id => @budget, :id => furnishings,
        :furnishings => {:chair_unit_price => 56.78}

    assert_not_nil assigns(:furnishings)
    assert_response :redirect
    assert_redirected_to budget_furnishings_path(@budget, assigns(:furnishings))
    assert_equal 56.78, assigns(:furnishings).chair_unit_price
    assert_equal "#{Furnishings.model_name.human_name.humanize} #{I18n.t('msgs.saved')}",
                 flash[:notice]
  end

  test "destroy" do
    furnishings = @budget.furnishings.create Factory.attributes_for(:furnishings)
    delete :destroy, :budget_id => @budget, :id => furnishings

    assert_not_nil assigns(:furnishings)
    @budget.reload
    assert_nil @budget.students_furnishings
    assert_response :redirect
    assert_redirected_to @budget
    assert_equal "#{Furnishings.model_name.human_name.humanize} #{I18n.t('msgs.deleted')}",
                 flash[:notice]
  end

  protected

  def setup
    @budget = Factory :budget
  end

end
