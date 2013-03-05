class Race < ActiveRecord::Base
  attr_accessible :ethnicity, :percent, :school_id
  belongs_to :school

  validates_presence_of :school 
end
