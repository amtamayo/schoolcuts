class SchoolAction < ActiveRecord::Base
  attr_accessible :action_id, :result_id, :school_id
  
  has_one :school
  belongs_to :result, :class_name => "School", :foreign_key => "result_id"
  belongs_to :action
  
end

