class SchoolAction < ActiveRecord::Base
  attr_accessible :action_id, :result_id, :school_id, :result_code
  
  has_one :school
  belongs_to :result, :class_name => "School", :foreign_key => "result_id"
  belongs_to :receiving_action
  belongs_to :action
  
end

