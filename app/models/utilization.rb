class Utilization < ActiveRecord::Base
  attr_accessible :homerooms, :ideal_capacity, :other_rooms, :school_id, :year_from, :year_to
  belongs_to :school

  validates_presence_of :school 
end
