class HomeController < ApplicationController
  def index
  	@schools = School.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end

  end
end
