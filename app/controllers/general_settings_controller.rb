class GeneralSettingsController < ApplicationController

  def new
    @budget = Budget.find_by_id params[:budget_id]
    if @budget
      @general_settings = @budget.build_general_settings
    else
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'record_not_found'}"
      redirect_to budgets_path
    end
  end

  def create
    @budget = Budget.find params[:budget_id]
    @general_settings = @budget.build_general_settings params[:general_settings]

    if @general_settings.save
      flash[:notice] = "#{GeneralSettings.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_general_settings_path(@budget)
    else
      render :action => 'new'
    end
  end

  def show
    @budget = Budget.find_by_id params[:budget_id], :include => :general_settings

    if @budget
      @general_settings = @budget.general_settings
    else
      flash[:error] = "#{GeneralSettings.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def edit
    @budget = Budget.find_by_id params[:budget_id], :include => :general_settings

    unless @budget
      flash[:error] = "#{GeneralSettings.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def update
    @budget = Budget.find params[:budget_id], :include => :general_settings

    if @budget.general_settings.update_attributes(params[:general_settings])
      flash[:notice] = "#{GeneralSettings.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_general_settings_path(@budget)
    else
      flash[:error] = "<br>"+@budget.general_settings.errors.full_messages.map { |err|
        err.humanize
      }.join('<br>')
      redirect_to :back
    end
  end

  def destroy
    @budget = Budget.find params[:budget_id], :include => :general_settings
    @budget.general_settings.delete
    flash[:notice] = "#{GeneralSettings.model_name.human.humanize} #{t('msgs.deleted').pluralize}"
    redirect_to @budget
  end

end