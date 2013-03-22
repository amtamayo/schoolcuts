class Action < ActiveRecord::Base
  attr_accessible :name
  
  belongs_to :school_action
end
