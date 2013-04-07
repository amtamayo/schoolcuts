class CompareController < ApplicationController
  def show
  	  @school = School.find(params[:id])
	  @associated_schools = @school.school_actions.map{|action| action.result }
  end
end
