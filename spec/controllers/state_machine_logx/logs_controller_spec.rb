require 'rails_helper'

module StateMachineLogx
  RSpec.describe LogsController, type: :controller do
    routes {StateMachineLogx::Engine.routes}
    before(:each) do
      expect(controller).to receive(:require_signin)
      expect(controller).to receive(:require_employee)
      #@pagination_config = FactoryGirl.create(:engine_config, :engine_name => nil, :engine_version => nil, :argument_name => 'pagination', :argument_value => 30)
    end
    
    before(:each) do
      z = FactoryGirl.create(:zone, :zone_name => 'hq')
      type = FactoryGirl.create(:group_type, :name => 'employee')
      ug = FactoryGirl.create(:sys_user_group, :user_group_name => 'ceo', :group_type_id => type.id, :zone_id => z.id)
      @role = FactoryGirl.create(:role_definition)
      ur = FactoryGirl.create(:user_role, :role_definition_id => @role.id)
      ul = FactoryGirl.build(:user_level, :sys_user_group_id => ug.id)
      @u = FactoryGirl.create(:user, :user_levels => [ul], :user_roles => [ur])
      #@qs = FactoryGirl.create(:commonx_misc_definition, :for_which => 'quality_system')
      
      session[:user_role_ids] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id).user_role_ids
    end
    
    render_views
    describe "GET 'index'" do
      it "returns wf logs" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'state_machine_logx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "StateMachineLogx::Log.order('created_at DESC')")
        session[:user_id] = @u.id
        sup = FactoryGirl.create(:state_machine_logx_log)
        get 'index'
        expect(assigns(:logs)).to   eq([sup])
      end
    end
  
    
    describe "GET 'show'" do
      it "returns the log" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'state_machine_logx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        sup = FactoryGirl.create(:state_machine_logx_log, :last_updated_by_id => session[:user_id], :action_by_name => 'some guy')
        get 'show', {:id => sup.id}
        expect(response).to be_success
      end
    end
  
  end
end