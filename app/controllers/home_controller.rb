class HomeController < ApplicationController
  def index
  	@status = 2
  	filter = "closing_status = #{@status}"
  	prelim_filter = "closing_status = 1"
  	receiving_filter = "receiving_status = 1"
  	turnaround_filter = "closing_status = 3"
  	relocating_filter = "closing_status = 4"
  	colocating_filter = "closing_status = 5"
  	closing_grades_filter = "closing_status = 6"
  	phasing_out_filter = "closing_status = 7"
  	new_turnaround_filter = "closing_status = 8"
  	
  	
  	@schools = School.where(filter).sort_by{ |s| s.short_name }
  	@students_affected = @schools.map{|s| s.enrollments.select{|e|e.year_from==2012}}.map{|e| e.first.count }.inject{|sum,x| sum + x}
  	@prelim_schools = School.where(prelim_filter).sort_by{|s| s.short_name }
  	@receiving_schools = School.where(receiving_filter).sort_by{|s| s.short_name }
  	@turnaround_schools = School.where(turnaround_filter).sort_by{|s| s.short_name }
  	@relocating_schools = School.where(relocating_filter).sort_by{|s| s.short_name }
  	@colocating_schools = School.where(colocating_filter).sort_by{|s| s.short_name }
  	@closing_grades_schools = School.where(closing_grades_filter).sort_by{|s| s.short_name }
  	@phasing_out_schools = School.where(phasing_out_filter).sort_by{|s| s.short_name }
  	@new_turnaround_schools = School.where(new_turnaround_filter).sort_by{|s| s.short_name }
  	
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end

  end
end
