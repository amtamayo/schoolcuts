class Enrollment < ActiveRecord::Base
  attr_accessible :count, :school_id, :year_from, :year_to
  belongs_to :school

  validates_presence_of :school
end
