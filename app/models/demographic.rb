class Demographic < ActiveRecord::Base
  attr_accessible :category, :percent, :school_id, :year_from, :year_to
  
  belongs_to :school
  
  validates_presence_of :school  

end
