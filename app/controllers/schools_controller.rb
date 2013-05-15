class SchoolsController < ApplicationController
  
  caches_page :index
  caches_page :show

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schools }
    end
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @school = School.find(params[:id])
    @year = 2012
    @enrollment = @school.enrollments_for_year(@year)
    @ideal_capacity = @school.ideal_capacity_for_year(@year)
    @first_enrollment_year = @school.first_enrollment_year
    @enrollment_totals = @school.enrollment_totals
	
	@latitude = @school.school_addresses.where('year_from=2012').first.address.latitude
	@longitude = @school.school_addresses.where('year_from=2012').first.address.longitude
	
	@address = @school.school_addresses.where('year_from=2012').first.address
	
	@status_with_transition_links = [1,2,3,4,6,7]
	
	utilization_rate = @enrollment.to_f / @ideal_capacity * 100
    
    case utilization_rate 
	    when 0..80
	    	@utilization_status = "Underutilized"
		when 80..120
		    @utilization_status = "Efficient"
		when utilization_rate > 120
			@utilization_status = "Overcrowded"
		else
			@utilization_status = "Overcrowded"
	end
	
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @school }
    end
  end

  # GET /schools/new
  # GET /schools/new.json
  def new
    @school = School.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @school }
    end
  end

  # GET /schools/1/edit
  def edit
    @school = School.find(params[:id])
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(params[:school])

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render json: @school, status: :created, location: @school }
      else
        format.html { render action: "new" }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /schools/1
  # PUT /schools/1.json
  def update
    @school = School.find(params[:id])

    respond_to do |format|
      if @school.update_attributes(params[:school])
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school = School.find(params[:id])
    @school.destroy

    respond_to do |format|
      format.html { redirect_to schools_url }
      format.json { head :no_content }
    end
  end
end
