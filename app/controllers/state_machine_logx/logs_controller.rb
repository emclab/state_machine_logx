require_dependency "state_machine_logx/application_controller"

module StateMachineLogx
  class LogsController < ApplicationController
    before_filter :require_employee
    
    def index
      @title = t('Workflow Logs')      
      @logs = params[:state_machine_logx_logs][:model_ar_r]
      @logs = @logs.where(:resource_string => params[:resource_string]) if params[:resource_string]
      @logs = @logs.where(:resource_id => params[:resource_id].to_i) if params[:resource_id]
      @erb_code = find_config_const('log_index_view', 'state_machine_logx')
    end
  
    def show
      @title = t('Workflow Log Info')
      @log = StateMachineLogx::Log.find_by_id(params[:id])
      @erb_code = find_config_const('log_show_view', 'state_machine_logx')
    end
  end
end
