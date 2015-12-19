module StateMachineLogx
  module StateMachineLogxHelper
    def state_machine_logger(resource_id, resource_string, action_by_name, wf_comment, from, to, event, last_updated_by_id, error=nil)
      log = Log.new({:resource_id => resource_id, :resource_string => resource_string, :action_by_name => action_by_name, :comment => wf_comment, :from => from, 
               :to => to, :event => event, :last_updated_by_id => last_updated_by_id, :error_message => error}) #, :as => :role_new)
      log.save
    end    
    module_function :state_machine_logger
  end
end