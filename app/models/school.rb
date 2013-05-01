class School < ActiveRecord::Base
attr_accessible :access_type, :community_area, :cps_id, :full_name, :latitude, :level, :longitude, :phone, :school_type, :short_name, :street_address, :zip, :isat_url, :closing_status, :receiving_status
  
  has_many :enrollments
  has_many :essentials
  has_many :isat_scores
  has_many :map_legends
  has_many :mobilities
  has_many :probations
  has_many :races
  has_many :utilizations
  has_many :demographics
  has_many :school_addresses
  has_many :school_actions
  has_one :performance_metric

  def enrollments_for_year(number)
    enrollment = enrollments.select('count').where({
      :year_from => number
    })
    enrollment.empty? ? 0 : enrollment.first.count
  end

  def enrollment_totals
    enrollments.select('count').order('year_from').map(&:count).to_json
  end

  def ideal_capacity_for_year(number)
    utilizations.select('ideal_capacity').where({
      :year_from => number
    }).first.ideal_capacity
  end

  def first_enrollment_year
    enrollments.select('year_to').order('year_to').limit(1).first.year_to
  end
  
  def current_empty_seats(year)
  	ideal_capacity_for_year(year) - enrollments_for_year(year)
  end 
  # empty seat - if relocating use the ideal capacity for the new building
  def proposed_empty_seats(year)
  	if self.is_relocating?
  		relocation = SchoolAction.find_by_result_id(self.id)
  		relocation_school = School.find_by_id(relocation.school_id)
  		relocation_school.ideal_capacity_for_year(year) - enrollments_for_year(year)
  	else
  		ideal_capacity_for_year(year) - enrollments_for_year(year)
  	end
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
  
  def closing_status_name
    @closing_status_name = self.closing_status.nil? ? "" : 
    Action.find_by_action_code(self.closing_status).nil? ? "" : 
    Action.find_by_action_code(self.closing_status).name 
    @closing_status_name
  end
  
  def receiving_status_name
    @receiving_status_name = self.receiving_status.nil? ? "" : "receiving"
    @receiving_status_name
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
    
  def is_receiving?
    self.receiving_status == 1 || self.receiving_status == 2
  end 
   
  def is_closing?
  	self.closing_status == 1
  end
  
  def is_turnaround?
  	self.closing_status == 2
  end
  
  def is_relocating?
    self.closing_status == 3
  end
  
  def is_colocating?
  	self.closing_status == 4
  end
  
  def is_program_closure?
  	self.closing_status == 5
  end
  
  def is_phaseout?
  	self.closing_status == 6
  end
  
  def is_special_turnaround?
  	self.closing_status == 7
  end
   
  def map_legends
  	@map_legends = MapLegend.where('school_id='+self.id.to_s)
  end
   
  def receiving_schools
  	@receiving_schools = self.school_actions.map{|r| if(r.action_id==2 || r.action_id==7) then  r.result_id end}.uniq.join(", ")
  end
  
  def receiving_school_names
	@receiving_school_names = self.school_actions.map{|r| if(r.action_id==2 || r.action_id==7) then  School.find_by_id(r.result_id).short_name end}
  end
  
  def receiving_school_links
	@receiving_school_links = self.school_actions.map{|r| if(r.action_id==2 || r.action_id==7) then  "/schools/" + r.result_id.to_s end}
  end

  def colocating_schools
   @colocating_schools = self.school_actions.map{|r| if(r.action_id==5) then  r.result_id end}.uniq.join(", ")
  end
  
  def sending_schools
  	@sending_schools = SchoolAction.where("result_id=" + self.id.to_s + "").map{|sa| if(sa.action_id==2 || sa.action_id==7) then sa.school_id end }.uniq.join(",")
  end 
  
  def sending_school_names
	@sending_school_names = SchoolAction.where("result_id=" + self.id.to_s + "").
		map{|sa| if(sa.action_id==2 || sa.action_id==7) then School.find_by_id(sa.school_id).short_name end }
  end
  
  def sending_school_links
	@sending_school_links = SchoolAction.where("result_id=" + self.id.to_s + "").
		map{|sa| if(sa.action_id==2 || sa.action_id==7) then "/schools/" + sa.school_id.to_s end }
  end
  
  def is_higher_performing?(other_school)
  
  	@score = 0
  	if self.performance_metric.policy_points > other_school.performance_metric.policy_points 
  		@score = @score + 1
  	end
    if self.performance_metric.isat_composite > other_school.performance_metric.isat_composite
  		@score = @score + 1
  	end
	if self.performance_metric.value_added_reading > other_school.performance_metric.value_added_reading
		@score = @score + 1
	end

	if self.performance_metric.value_added_math > other_school.performance_metric.value_added_math
		@score = @score + 1
	end
  
  	self.level < other_school.level ||  @score > 2  		  		
  end 
  
  def new_building(format)
  	@result = nil 
  	@new_building_school_id = -1
  	@new_building_school_name = ""
  	@new_building_school_link = "#"
  	
  	if(self.school_actions.size > 0 && !self.school_actions.find_by_action_id(4).nil?)
  		@new_building_school_id = self.school_actions.find_by_action_id(4).result_id
  		@new_building_school_name = School.find_by_id(@new_building_school_id).short_name
  		@new_building_school_link = "/schools/" + @new_building_school_id.to_s
  	end
  	
  	case format
  		when "id"
  			@result = @new_building_school_id
  		when "name"
  			@result = @new_building_school_name
  		when "link"
  			@result = @new_building_school_link
  	end 
  	
	@result
  end
  
end
