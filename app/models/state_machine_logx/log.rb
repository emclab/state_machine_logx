module StateMachineLogx
  class Log < ActiveRecord::Base
    default_scope {where(fort_token: Thread.current[:fort_token])}
    
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    
    validates_presence_of :resource_string, :action_by_name, :fort_token
    validates :resource_id, :presence => true,
                            :numericality => {:greater_than => 0, :message => I18n.t('Invalid Resource#') }
  end
end
