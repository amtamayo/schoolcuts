class School < ActiveRecord::Base
  attr_accessible :access_type, :community_area, :cps_id, :full_name, :latitude, :level, :longitude, :phone, :school_type, :short_name, :street_address, :zip
  
  has_many :races
  has_many :mobilities
  has_many :isat_scores
  has_many :enrollments
  has_many :essentials
  has_many :probations
end
