require 'rails_helper'

module StateMachineLogx
  RSpec.describe Log, type: :model do
    it "should be OK" do
      c = FactoryGirl.build(:state_machine_logx_log)
      expect(c).to be_valid
    end
    
    it "should reject nil action by name" do
      c = FactoryGirl.build(:state_machine_logx_log, :action_by_name => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject nil resource name" do
      c = FactoryGirl.build(:state_machine_logx_log, :resource_string => nil)
      expect(c).not_to be_valid
    end
    
    it "should reject 0 resource id" do
      c = FactoryGirl.build(:state_machine_logx_log, :resource_id => 0)
      expect(c).not_to be_valid
    end

  end
end
