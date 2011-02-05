class LanSettingsController < ApplicationController

  def new
    @budget = Budget.find_by_id params[:budget_id]
    if @budget
      @lan_settings = @budget.build_lan_settings
    else
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'record_not_found'}"
      redirect_to budgets_path
    end
  end

  def create
    @budget = Budget.find params[:budget_id]
    @lan_settings = @budget.build_lan_settings params[:lan_settings]

    if @lan_settings.save
      flash[:notice] = "#{LanSettings.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_lan_settings_path(@budget)
    else
      render :action => 'new'
    end
  end

  def show
    @budget = Budget.find_by_id params[:budget_id], :include => [:general_settings,
                                                                :hardware_prices,
                                                                :lan_settings]

    if @budget
      @lan_settings = @budget.lan_settings
    else
      flash[:error] = "#{LanSettings.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def edit
    @budget = Budget.find_by_id params[:budget_id], :include => :lan_settings

    unless @budget
      flash[:error] = "#{LanSettings.model_name.human.humanize} #{t('msgs.record_not_found').pluralize}"
      redirect_to budgets_path
    end
  end

  def update
    @budget = Budget.find params[:budget_id], :include => :lan_settings

    if @budget.lan_settings.update_attributes(params[:lan_settings])
      flash[:notice] = "#{LanSettings.model_name.human.humanize} #{t('msgs.saved').pluralize}"
      redirect_to budget_lan_settings_path(@budget)
    else
      flash[:error] = "<br>"+@budget.lan_settings.errors.full_messages.map { |err|
        err.humanize
      }.join('<br>')
      redirect_to :back
    end
  end

  def destroy
    @budget = Budget.find params[:budget_id], :include => :lan_settings
    @budget.lan_settings.delete
    flash[:notice] = "#{LanSettings.model_name.human.humanize} #{t('msgs.deleted').pluralize}"
    redirect_to @budget
  end

end
