class Action < ActiveRecord::Base
  attr_accessible :name, :action_code
  
  belongs_to :school_action
  
end
