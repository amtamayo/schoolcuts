class ReceivingAction < ActiveRecord::Base
  attr_accessible :name, :receiving_code
  
  belongs_to :school_action
end
