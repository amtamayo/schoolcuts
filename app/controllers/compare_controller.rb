class CompareController < ApplicationController
  
  caches_page :show

  def show
  	  @school = School.find(params[:id])
	  @associated_schools = @school.school_actions.sort{|a,b| a.result_code <=> b.result_code}.map{|action| action.result }.uniq(&:id)
  end
end
