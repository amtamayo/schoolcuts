class HomeController < ApplicationController
  def index
  	@schools = School.all.sort_by{|s| s.short_name }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end

  end
end
