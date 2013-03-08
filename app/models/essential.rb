class Essential < ActiveRecord::Base
  attr_accessible :category, :rating, :school_id, :year_from, :year_to
  
  belongs_to :school
  validates_presence_of :school 
end
