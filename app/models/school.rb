class School < ActiveRecord::Base
  attr_accessible :access_type, :community_area, :cps_id, :full_name, :latitude, :longitude, :school_type, :short_name, :street_address
end
