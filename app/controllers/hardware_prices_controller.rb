class HardwarePricesController < ApplicationController

  def new
    @budget = Budget.find_by_id params[:budget_id]
    if @budget
      @hardware_prices = @budget.build_hardware_prices
    else
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'record_not_found'}"
      redirect_to budgets_path
    end
  end

  def create
    @budget = Budget.find params[:budget_id]
    @hardware_prices = @budget.build_hardware_prices params[:hardware_prices]

    if @hardware_prices.save
      flash[:notice] = "#{HardwarePrices.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_hardware_prices_path(@budget)
    else
      render :action => 'new'
    end
  end

  def show
    @budget = Budget.find_by_id params[:budget_id], :include => :hardware_prices

    if @budget
      @hardware_prices = @budget.hardware_prices
    else
      flash[:error] = "#{HardwarePrices.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def edit
    @budget = Budget.find_by_id params[:budget_id], :include => :hardware_prices

    unless @budget
      flash[:error] = "#{HardwarePrices.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def update
    @budget = Budget.find params[:budget_id], :include => :hardware_prices

    if @budget.hardware_prices.update_attributes(params[:hardware_prices])
      flash[:notice] = "#{HardwarePrices.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_hardware_prices_path(@budget)
    else
      flash[:error] = "<br>"+@budget.hardware_prices.errors.full_messages.map { |err|
        err.humanize
      }.join('<br>')
      redirect_to :back
    end
  end

  def destroy
    @budget = Budget.find params[:budget_id], :include => :hardware_prices
    @budget.hardware_prices.delete
    flash[:notice] = "#{HardwarePrices.model_name.human.humanize} #{t('msgs.deleted').pluralize}"
    redirect_to @budget
  end

end
