require 'test_helper'

class HardwarePricesControllerTest < ActionController::TestCase

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
    assert_not_nil assigns(:hardware_prices)
    assert_equal assigns(:budget).id, assigns(:hardware_prices).budget_id
  end

  test "create invalid" do
    post :create, :budget_id => @budget, :hardware_prices => {:ram_unit_price => -1}

    assert_response :ok
    assert_template 'new'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:hardware_prices)
    assert assigns(:hardware_prices).new_record?
  end

  test "create" do
    post :create, :budget_id => @budget,
         :hardware_prices => Factory.attributes_for(:hardware_prices)

    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:hardware_prices)
    assert_response :redirect
    assert_redirected_to budget_hardware_prices_path(assigns(:budget))
    assert_equal "#{HardwarePrices.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end
  
  test "show-edit invalid" do
    get :show, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:budget)
    assert_equal HardwarePrices.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
                 
    get :edit, :budget_id => 0
    assert_response :redirect
    assert_redirected_to budgets_path
    assert_nil assigns(:budget)
    assert_equal HardwarePrices.model_name.human_name.humanize+" "+I18n.t('msgs.record_not_found').pluralize,
                 flash[:error]
  end

  test "show" do
    hardware_prices = @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
    get :show, :budget_id => @budget

    assert_response :ok
    assert_template 'show'
    assert_not_nil assigns(:budget)
    assert_not_nil assigns(:hardware_prices)
    assert_equal hardware_prices, assigns(:hardware_prices)
  end

  test "edit" do
    @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
    get :edit, :budget_id => @budget

    assert_response :ok
    assert_template 'edit'
    assert_not_nil assigns(:budget)
  end

  test "update invalid" do
    @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
    @request.env["HTTP_REFERER"] = edit_budget_hardware_prices_path(@budget)
    put :update, :budget_id => @budget, :hardware_prices => {:ram_unit_price => -1}

    assert_response :redirect
    assert_redirected_to edit_budget_hardware_prices_path(@budget)
    assert_not_nil flash[:error]
  end

  test "update" do
    @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
    put :update, :budget_id => @budget, :hardware_prices => {:ram_unit_price => 30}

    assert_response :redirect
    assert_redirected_to budget_hardware_prices_path(@budget)
    assert_not_nil assigns(:budget)
    assert_equal 30, assigns(:budget).hardware_prices.ram_unit_price
    assert_equal "#{HardwarePrices.model_name.human_name.humanize} #{I18n.t('msgs.saved').pluralize}",
                 flash[:notice]
  end

  test "destroy" do
    @budget.create_hardware_prices Factory.attributes_for(:hardware_prices)
    delete :destroy, :budget_id => @budget

    assert_not_nil assigns(:budget)
    assigns(:budget).reload
    assert_nil assigns(:budget).hardware_prices
    assert_response :redirect
    assert_redirected_to @budget
    assert_equal "#{HardwarePrices.model_name.human_name.humanize} #{I18n.t('msgs.deleted').pluralize}",
                 flash[:notice]
  end

  protected

  def setup
    @budget = Factory :budget
  end

end
