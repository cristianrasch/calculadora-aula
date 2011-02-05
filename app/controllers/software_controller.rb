class SoftwareController < ApplicationController
  
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
      @software = @budget.software.build :target => params[:target]
    else
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'record_not_found'}"
      redirect_to budgets_path
    end
  end

  def create
    @budget = Budget.find params[:budget_id]
    @software = @budget.software.build params[:software]

    if @software.save
      flash[:notice] = "#{Software.model_name.human.humanize} #{t('msgs.saved')}"
      redirect_to budget_software_path(@budget, @software)
    else
      render :action => 'new'
    end
  end

  def show
    @software = Software.find_by_id params[:id], :include => :budget
    if @software
      @budget = @software.budget
    else
      flash[:error] = "#{Software.model_name.human.humanize} #{t('msgs.record_not_found')}"
      redirect_to budgets_path
    end
  end

  def edit
    @software = Software.find_by_id params[:id], :include => :budget
    if @software
      @budget = @software.budget
    else
      flash[:error] = "#{Software.model_name.human.humanize} #{t('msgs.record_not_found')}"
      redirect_to budgets_path
    end
  end

  def update
    @software = Software.find params[:id], :include => :budget

    if @software.update_attributes(params[:software])
      flash[:notice] = "#{Software.model_name.human.humanize} #{t('msgs.saved')}"
      redirect_to budget_software_path(@software.budget, @software)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @software = Software.find params[:id], :include => :budget
    @software.delete
    flash[:notice] = "#{Software.model_name.human.humanize} #{t('msgs.deleted')}"
    redirect_to @software.budget
  end
  
end
