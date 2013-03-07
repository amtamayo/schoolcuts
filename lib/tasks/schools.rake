require 'csv'

namespace :cps do
	desc "import school data"
	task :import_schools => :environment do
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"

		list = CSV.read(inputfile, :headers => true )
		
		list.each { | row | 
			puts row[0].to_s + " " + row[1].to_s
			school = School.find_by_cps_id(row[0].to_i)
			if school.nil?
				School.create(
					:access_type => row[9].to_s,
					:community_area => row[5].to_s,
					:cps_id => row[0].to_i,
					:full_name => row[2].to_s,
					:latitude => row[6].to_f,
					:longitude => row[7].to_f,
					:school_type => row[8].to_s,
					:short_name => row[1].to_s,
					:street_address => row[4].to_s
				)
			else
				school.access_type = row[9].to_s
				school.community_area = row[5].to_s
				school.cps_id = row[0].to_i
				school.full_name = row[2].to_s
				school.latitude = row[6].to_f
				school.longitude = row[7].to_f
				school.school_type = row[8].to_s
				school.short_name = row[1].to_s
				school.street_address = row[4].to_s
			end
		}
	end
	
	desc "import race demographics"
	task :import_race => :environment do
		
		Race.delete_all()
	
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"

		list = CSV.read(inputfile, :headers => true )
		list.each { |row|
			school = School.find_by_cps_id(row[0].to_i)
			if (!school.nil?)
				puts "Importing race demographic for #{row[1].to_s}"
				Race.create(:school_id=>school.id, :ethnicity=>'Asian', :percent=>row[11].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Black', :percent=>row[12].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Hispanic', :percent=>row[13].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Multi-racial', :percent=>row[14].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Native American', :percent=>row[15].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Not Available', :percent=>row[16].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Hawaiian Pacific', :percent=>row[17].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'White', :percent=>row[18].to_f)
			else
				puts "School #{row[1].to_s} not found"
			end
		}
		
	end
	
	desc "import mobility rates"
	task :import_mobility_rates => :environment do
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"
		
		Mobility.delete_all()
		
		list = CSV.read(inputfile, :headers => true)
		list.each { |row|
			school = School.find_by_cps_id(row[0].to_i)
			if(!school.nil?)
				puts "Importing mobility rates for #{row[1].to_s} #{row[65].to_s}"
				Mobility.create(:school_id=>school.id, :year_from=>1999, :year_to=>2000, :rate=>row[65].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2000, :year_to=>2001, :rate=>row[66].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2001, :year_to=>2002, :rate=>row[67].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2002, :year_to=>2003, :rate=>row[68].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2003, :year_to=>2004, :rate=>row[69].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2004, :year_to=>2005, :rate=>row[70].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2005, :year_to=>2006, :rate=>row[71].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2006, :year_to=>2007, :rate=>row[72].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2007, :year_to=>2008, :rate=>row[73].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2008, :year_to=>2009, :rate=>row[74].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2009, :year_to=>2010, :rate=>row[75].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2010, :year_to=>2011, :rate=>row[76].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2011, :year_to=>2012, :rate=>row[77].to_f)
			else
				puts "School #{row[1].to_s} not found"
			end
		}
	end

	desc "import isat scores"
	task :import_isat_score => :environment do
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"
		
		IsatScore.delete_all()

		list = CSV.read(inputfile, :headers => true )
		list.each { |row|
			school = School.find_by_cps_id(row[0].to_i)
			if (!school.nil?)
				puts "Importing ISAT scores for #{row[1].to_s}"
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2006, :year_to=>2007, :percent=>row[88].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2007, :year_to=>2008, :percent=>row[89].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2008, :year_to=>2009, :percent=>row[90].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2009, :year_to=>2010, :percent=>row[91].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2010, :year_to=>2011, :percent=>row[92].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2011, :year_to=>2012, :percent=>row[93].to_f)
				
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2006, :year_to=>2007, :percent=>row[100].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2007, :year_to=>2008, :percent=>row[101].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2008, :year_to=>2009, :percent=>row[102].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2009, :year_to=>2010, :percent=>row[103].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2010, :year_to=>2011, :percent=>row[104].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2011, :year_to=>2012, :percent=>row[105].to_f)
				
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2006, :year_to=>2007, :percent=>nil)
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2007, :year_to=>2008, :percent=>row[112].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2008, :year_to=>2009, :percent=>nil)
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2009, :year_to=>2010, :percent=>nil)
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2010, :year_to=>2011, :percent=>row[113].to_f)				
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2011, :year_to=>2012, :percent=>nil)
			else
				puts "School #{row[1].to_s} not found"
			end
		}
	end
	
    desc "import enrollment"
    task :import_enrollment => :environment do
        inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"

        Enrollment.delete_all()
        
        list = CSV.read(inputfile, :headers => true)
        list.each { |row|
        	school = School.find_by_cps_id(row[0].to_i)
        	if (!school.nil?)
        	    puts "Enrollment for #{row[0].to_s} #{row[1].to_s}"
        	    Enrollment.create(:school_id=>school.id, :year_from=>1999, :year_to=>2000, :count=>row[31].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2000, :year_to=>2001, :count=>row[32].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2001, :year_to=>2002, :count=>row[33].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2002, :year_to=>2003, :count=>row[34].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2003, :year_to=>2004, :count=>row[35].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2004, :year_to=>2005, :count=>row[36].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2005, :year_to=>2006, :count=>row[37].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2006, :year_to=>2007, :count=>row[38].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2007, :year_to=>2008, :count=>row[39].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2008, :year_to=>2009, :count=>row[40].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2009, :year_to=>2010, :count=>row[41].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2010, :year_to=>2011, :count=>row[42].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2011, :year_to=>2012, :count=>row[43].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2012, :year_to=>2013, :count=>row[44].to_i)
        	else
        	 	puts "School #{row[1].to_s} not found"
            end
        }
    end

	desc "Show column names"
		task :list_import_column_names => :environment do
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"

		list = CSV.read(inputfile, :headers => true )
		list.header
    end
	
	desc "Show path"
		task :show_default_path => :environment do
		puts "PATH: #{Rails.root.to_s}/lib/tasks/data/schools.csv"
    end
    
    desc "Monster Task"
    	task :reset_all do
    	inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"
    	
    	Rake::Task['db:drop'].invoke
    	Rake::Task['db:create'].invoke
    	Rake::Task['db:migrate'].invoke
    	Rake::Task['cps:import_all'].invoke
    end
    
    desc "Import all tables"
    	task :import_all do
    	inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"
    	
    	Rake::Task['cps:import_schools'].invoke
    	Rake::Task['cps:import_race'].invoke
    	Rake::Task['cps:import_isat_score'].invoke
    	Rake::Task['cps:import_enrollment'].invoke
    	Rake::Task['cps:import_mobility_rates'].invoke
    end
end


