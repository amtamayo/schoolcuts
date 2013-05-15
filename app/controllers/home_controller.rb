class HomeController < ApplicationController

  def index
  	include_status = [1,2,3,4,5,6,7]
  	@schools = Rails.cache.fetch('home.schools') { School.where("closing_status> 0 or receiving_status in (1, 2)").sort_by{ |s| s.short_name } }
  	@students_affected = Rails.cache.fetch('home.students_affected') { @schools.map{|s| s.enrollments_for_year(2012)}.inject{|sum,x| sum + x} }
  	@receiving_schools = Rails.cache.fetch('home.receiving_schools') { School.where("receiving_status = 1").sort_by{|s| s.short_name } }
  	
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end

  end
end
