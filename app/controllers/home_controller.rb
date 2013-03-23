class HomeController < ApplicationController
  def index
  	@status = 
  	  	
  	
  	@schools = School.all.select{ |s| (!s.closing_status.nil? && s.closing_status > 1 ) || s.receiving_status == 1}.sort_by{ |s| s.short_name }
  	@students_affected = @schools.map{|s| s.enrollments.select{|e|e.year_from==2012}}.map{|e| e.first.count }.inject{|sum,x| sum + x}
  	@receiving_schools = School.where("receiving_status = 1").sort_by{|s| s.short_name }
  	
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end

  end
end
