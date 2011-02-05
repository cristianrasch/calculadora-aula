class BudgetsController < ApplicationController
  
  prawnto :inline => false
  
  def index
    @budgets = Budget.paginate :page => params[:page]
  end
  
  def new
    @budget = Budget.new
  end
  
  def create
    @budget = Budget.new params[:budget]
    
    if @budget.save
      flash[:notice] = "#{Budget.model_name.human.humanize} #{t 'msgs.saved'}"
      redirect_to @budget
    else
      render :action => 'new'
    end
  end
  
  def show
    @budget = Budget.find_by_id params[:id], 
                                :include => [:general_settings, :hardware_prices, 
                                            :lan_settings, :students_workstations_settings, 
                                            :teachers_workstations_settings, 
                                            :servers_workstations_settings, 
                                            :thin_clients_workstations_settings, 
                                            :students_furnishings, :teachers_furnishings, 
                                            :servers_furnishings, :students_standalone_software, 
                                            :teachers_standalone_software, :tc_server_software, 
                                            :tc_software, :settings]
    
    unless @budget
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'msgs.record_not_found'}"
      redirect_to budgets_path
    end
  end
  
  def summarize
    @budget = Budget.find_by_id params[:id], 
                                :include => [:general_settings, :hardware_prices, 
                                            :lan_settings, :students_workstations_settings, 
                                            :teachers_workstations_settings, 
                                            :servers_workstations_settings, 
                                            :thin_clients_workstations_settings, 
                                            :students_furnishings, :teachers_furnishings, 
                                            :servers_furnishings, :students_standalone_software, 
                                            :teachers_standalone_software, :tc_server_software, 
                                            :tc_software, :settings]
    
    unless @budget
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'msgs.record_not_found'}"
      redirect_to budgets_path
    end
  end
  
  def edit
    @budget = Budget.find_by_id params[:id]
    
    unless @budget
      flash[:error] = "#{Budget.model_name.human.humanize} #{t 'msgs.record_not_found'}"
      redirect_to budgets_path
    end
  end
  
  def update
    @budget = Budget.find params[:id]
    
    if @budget.update_attributes params[:budget]
      flash[:notice] = "#{Budget.model_name.human.humanize} #{t 'msgs.saved'}"
      redirect_to @budget
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @budget = Budget.find params[:id]
    @budget.destroy
    flash[:notice] = "#{Budget.model_name.human.humanize} #{t 'msgs.deleted'}"
    redirect_to budgets_path
  end
  
end
