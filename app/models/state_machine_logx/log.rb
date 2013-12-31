module StateMachineLogx
  class Log < ActiveRecord::Base
    attr_accessible :action_by_name, :comment, :error_message, :event, :from, :resource_string, :resource_id, :to, :last_updated_by_id, :as => :role_new
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    
    validates_presence_of :resource_string, :action_by_name
    validates :resource_id, :presence => true,
                            :numericality => {:greater_than => 0, :message => I18n.t('Invalid Resource#') }
  end
end
