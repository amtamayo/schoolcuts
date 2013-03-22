class SchoolAddress < ActiveRecord::Base
  attr_accessible :address_id, :school_id, :year_from, :year_to
  
  has_one :school
  belongs_to :address
end
