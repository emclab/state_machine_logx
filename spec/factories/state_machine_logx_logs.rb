# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :state_machine_logx_log, :class => 'StateMachineLogx::Log' do
    resource_string "My resource String"
    resource_id 1
    event "My event String"
    action_by_name "My name String"
    comment "MyText"
    from "from"
    to "to"
    error_message "My error Text"
    last_updated_by_id 1
  end
end
