class FurnishingsController < ApplicationController

  def index
    @budget = Budget.find_by_id params[:budget_id]

    unless @budget
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'record_not_found'}"
      redirect_to budgets_path
    end
  end

  def new
    @budget = Budget.find_by_id params[:budget_id]
    if @budget
      @furnishings = @budget.furnishings.build :target => params[:target]
    else
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'record_not_found'}"
      redirect_to budgets_path
    end
  end

  def create
    @budget = Budget.find params[:budget_id]
    @furnishings = @budget.furnishings.build params[:furnishings]

    if @furnishings.save
      flash[:notice] = "#{Furnishings.model_name.human.humanize} #{t('msgs.saved')}"
      redirect_to budget_furnishings_path(@budget, @furnishings)
    else
      render :action => 'new'
    end
  end

  def show
    @furnishings = Furnishings.find_by_id params[:id], :include => :budget
    if @furnishings
      @budget = @furnishings.budget
    else
      flash[:error] = "#{Furnishings.model_name.human.humanize} #{t('msgs.record_not_found')}"
      redirect_to budgets_path
    end
  end

  def edit
    @furnishings = Furnishings.find_by_id params[:id], :include => :budget
    if @furnishings
      @budget = @furnishings.budget
    else
      flash[:error] = "#{Furnishings.model_name.human.humanize} #{t('msgs.record_not_found')}"
      redirect_to budgets_path
    end
  end

  def update
    @furnishings = Furnishings.find params[:id], :include => :budget

    if @furnishings.update_attributes(params[:furnishings])
      flash[:notice] = "#{Furnishings.model_name.human.humanize} #{t('msgs.saved')}"
      redirect_to budget_furnishings_path(@furnishings.budget, @furnishings)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @furnishings = Furnishings.find params[:id], :include => :budget
    @furnishings.delete
    flash[:notice] = "#{Furnishings.model_name.human.humanize} #{t('msgs.deleted')}"
    redirect_to @furnishings.budget
  end

end
