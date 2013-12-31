require 'spec_helper'

module StateMachineLogx
  describe Log do
    it "should be OK" do
      c = FactoryGirl.build(:state_machine_logx_log)
      c.should be_valid
    end
    
    it "should reject nil action by name" do
      c = FactoryGirl.build(:state_machine_logx_log, :action_by_name => nil)
      c.should_not be_valid
    end
    
    it "should reject nil resource name" do
      c = FactoryGirl.build(:state_machine_logx_log, :resource_string => nil)
      c.should_not be_valid
    end
    
    it "should reject 0 resource id" do
      c = FactoryGirl.build(:state_machine_logx_log, :resource_id => 0)
      c.should_not be_valid
    end

  end
end
