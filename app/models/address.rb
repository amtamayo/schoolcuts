class Address < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :street_address, :zipcode

  belongs_to :school_address  
end
