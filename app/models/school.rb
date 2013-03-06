class School < ActiveRecord::Base
  attr_accessible :access_type, :community_area, :cps_id, :full_name, :latitude, :longitude, :school_type, :short_name, :street_address
  
  has_many :races
<<<<<<< HEAD
  has_many :isat_scores
=======
>>>>>>> 035ae6a3d14e8f1c0b14cb2983e76e09048b162e
  has_many :enrollments
end
