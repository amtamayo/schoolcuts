class HomeController < ApplicationController
  def index
  	include_status = [2,3,4,5,6,7,8]
  	@schools = School.all.select{ |s| include_status.find_index(s.closing_status) || s.receiving_status == 1}.sort_by{ |s| s.short_name }
  	@students_affected = @schools.map{|s| s.enrollments.select{|e|e.year_from==2012}}.map{|e| e.first.count }.inject{|sum,x| sum + x}
  	@receiving_schools = School.where("receiving_status = 1").sort_by{|s| s.short_name }
  	
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end

  end
end
