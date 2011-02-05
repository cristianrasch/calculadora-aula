class SettingsController < ApplicationController
  
  def new
    @budget = Budget.find_by_id params[:budget_id]
    if @budget
      @settings = @budget.build_settings
    else
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'record_not_found'}"
      redirect_to budgets_path
    end
  end

  def create
    @budget = Budget.find params[:budget_id]
    @settings = @budget.build_settings params[:settings]

    if @settings.save
      flash[:notice] = "#{Settings.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_settings_path(@budget)
    else
      render :action => 'new'
    end
  end

  def show
    @budget = Budget.find_by_id params[:budget_id], 
                                :include => [:settings, :lan_settings]

    if @budget
      @settings = @budget.settings
    else
      flash[:error] = "#{Settings.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def edit
    @budget = Budget.find_by_id params[:budget_id], :include => :settings

    if @budget
      @settings = @budget.settings
    else
      flash[:error] = "#{Settings.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def update
    @budget = Budget.find params[:budget_id], :include => :settings

    if @budget.settings.update_attributes(params[:settings])
      flash[:notice] = "#{Settings.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_settings_path(@budget)
    else
      flash[:error] = "<br>"+@budget.settings.errors.full_messages.map { |err|
        err.humanize
      }.join('<br>')
      redirect_to :back
    end
  end

  def destroy
    @budget = Budget.find params[:budget_id], :include => :settings
    @budget.settings.delete
    flash[:notice] = "#{Settings.model_name.human.humanize} #{t('msgs.deleted').pluralize}"
    redirect_to @budget
  end
  
end
