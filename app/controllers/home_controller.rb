class HomeController < ApplicationController
  def index
  	@status = 1
  	filter = "closing_status = #{@status}"
  	prelim_filter = "closing_status = 0"
  	receiving_filter = "receiving_status = 1"
  	relocating_filter = "closing_status = 4"
  	@schools = School.where(filter).sort_by{ |s| s.short_name }
  	@students_affected = @schools.map{|s| s.enrollments.select{|e|e.year_from==2012}}.map{|e| e.first.count }.inject{|sum,x| sum + x}
  	@prelim_schools = School.where(prelim_filter).sort_by{|s| s.short_name }
  	@receiving_schools = School.where(receiving_filter).sort_by{|s| s.short_name }
  	@relocating_schools = School.where(relocating_filter).sort_by{|s| s.short_name }
  	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end

  end
end
