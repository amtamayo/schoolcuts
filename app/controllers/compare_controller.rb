class CompareController < ApplicationController

  def show
  	@school = Rails.cache.fetch("compare.school.#{params[:id]}") { School.find(params[:id]) }
	  @associated_schools = Rails.cache.fetch("compare.associated_schools.#{params[:id]}") { @school.school_actions.sort{|a,b| a.result_code <=> b.result_code}.map{|action| action.result }.uniq(&:id) }
  end
end
