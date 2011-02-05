class WorkstationsSettingsController < ApplicationController

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
      @workstations_settings = @budget.workstations_settings.build :target => params[:target]
    else
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'record_not_found'}"
      redirect_to budgets_path
    end
  end

  def create
    @budget = Budget.find params[:budget_id]
    @workstations_settings = @budget.workstations_settings.build params[:workstations_settings]

    if @workstations_settings.save
      flash[:notice] = "#{WorkstationsSettings.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_workstations_settings_path(@budget, @workstations_settings)
    else
      render :action => 'new'
    end
  end

  def show
    @workstations_settings = WorkstationsSettings.find_by_id params[:id], 
                                                             :include => [:budget => :hardware_prices]
    if @workstations_settings
      @budget = @workstations_settings.budget
    else
      flash[:error] = "#{WorkstationsSettings.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def edit
    @workstations_settings = WorkstationsSettings.find_by_id params[:id], :include => :budget
    if @workstations_settings
      @budget = @workstations_settings.budget
    else
      flash[:error] = "#{WorkstationsSettings.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def update
    @workstations_settings = WorkstationsSettings.find params[:id], :include => :budget

    if @workstations_settings.update_attributes(params[:workstations_settings])
      flash[:notice] = "#{WorkstationsSettings.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_workstations_settings_path(@workstations_settings.budget, @workstations_settings)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @workstations_settings = WorkstationsSettings.find params[:id], :include => :budget
    @workstations_settings.delete
    flash[:notice] = "#{WorkstationsSettings.model_name.human.humanize} #{t('msgs.deleted').pluralize}"
    redirect_to @workstations_settings.budget
  end

end
