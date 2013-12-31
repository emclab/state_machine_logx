require 'spec_helper'

module StateMachineLogx
  describe LogsController do
    before(:each) do
      controller.should_receive(:require_signin)
      controller.should_receive(:require_employee)
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
      
    end
    
    render_views
    describe "GET 'index'" do
      it "returns wf logs" do
        user_access = FactoryGirl.create(:user_access, :action => 'index', :resource => 'state_machine_logx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "StateMachineLogx::Log.order('created_at DESC')")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.create(:state_machine_logx_log)
        get 'index', {:use_route => :tate_machine_logx}
        assigns(:logs).should =~ [sup]
      end
    end
  
    
    describe "GET 'show'" do
      it "returns the log" do
        user_access = FactoryGirl.create(:user_access, :action => 'show', :resource => 'state_machine_logx_logs', :role_definition_id => @role.id, :rank => 1,
        :sql_code => "")
        session[:user_id] = @u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(@u.id)
        sup = FactoryGirl.create(:state_machine_logx_log, :last_updated_by_id => session[:user_id], :action_by_name => 'some guy')
        get 'show', {:use_route => :state_machine_logx, :id => sup.id}
        response.should be_success
      end
    end
  
  end
end
