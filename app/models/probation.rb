class Probation < ActiveRecord::Base
  attr_accessible :school_id, :status, :year_from, :year_to
  belongs_to :school

  validates_presence_of :school 
end
