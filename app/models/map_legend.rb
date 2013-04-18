class MapLegend < ActiveRecord::Base
  attr_accessible :description, :marker, :school_id
  belongs_to :school
  
  validates_presence_of :school
end
