class PerformanceMetric < ActiveRecord::Base
  attr_accessible :isat_composite, :policy_points, :school_id, :value_added_math, :value_added_reading
  
  belongs_to :school
end
