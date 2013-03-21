class HomeController < ApplicationController
  def index
  	@status = 1
  	filter = "closing_status <= #{@status}"
  	@schools = School.where(filter).sort_by{ |s| s.short_name }
  	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end

  end
end
