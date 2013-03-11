class IsatScore < ActiveRecord::Base
  attr_accessible :percent, :school_id, :subject, :year_from, :year_to
  belongs_to :school
  
  validates_presence_of :school  

end
