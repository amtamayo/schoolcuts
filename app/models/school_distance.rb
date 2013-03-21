class SchoolDistance < ActiveRecord::Base
  attr_accessible :distance, :from_school_id, :to_school_id
  
  belongs_to :school, :foreign_key => "from_school_id"
  
end
