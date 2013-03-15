class School < ActiveRecord::Base
  attr_accessible :access_type, :community_area, :cps_id, :full_name, :latitude, :level, :longitude, :phone, :school_type, :short_name, :street_address, :zip, :isat_url
  
  has_many :enrollments
  has_many :essentials
  has_many :isat_scores
  has_many :mobilities
  has_many :probations
  has_many :races
  has_many :utilizations
  has_many :demographics

  def enrollments_for_year(number)
    enrollments.select('count').where({
      :year_from => number
    }).first.count
  end

  def enrollment_totals
    enrollments.select('count').order('year_from').map(&:count).to_json
  end

  def ideal_capacity_for_year(number)
    utilitizations.select('count').where({
      :year_from => number
    }).first.ideal_capacity
  end

  def first_enrollment_year
    enrollments.select('year_to').order('year_to').limit(1).first.year_to
  end
  
  def scores_for(subject)
  	self.isat_scores.select{|s| s.subject.downcase == subject.downcase }
  end
  
  def reading
  	@scores = scores_for("reading")
  	@scores
  end
  
  def science
  	@scores = scores_for("science")
  	@scores
  end
  
  def math
  	@scores = scores_for("math")
  	@scores
  end
  
  def students_per_homeroom(year)
  
  	@result=nil
  	if (self.school_type.include? "Special Ed")
		@result=nil 
	else
	  	@homerooms = self.utilizations.select{ |u| u.year_from==year}.first.homerooms
	  	@enrollment = self.enrollments.select{ |e| e.year_from==year}.first.count
	  	
	  	if (@homerooms.nil? || @homerooms==0)
	  		@result = nil
	  	else
	  		@result = (@enrollment / @homerooms).to_i
	  	end
  	end
  	@result
  end
    
end
