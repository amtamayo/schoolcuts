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
					:full_name => row[3].to_s,
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
				school.full_name = row[3].to_s
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
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"

		list = CSV.read(inputfile, :headers => true )
		list.each { |row|
			school = School.find_by_cps_id(row[0].to_i)
			if (!school.nil?)
				puts "Importing race demographic for #{row[1].to_s}"
				Race.create(:school_id=>school.id, :ethnicity=>'Asian', :percent=>row[10].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Black', :percent=>row[11].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Hispanic', :percent=>row[12].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Multi-racial', :percent=>row[13].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Native American', :percent=>row[14].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Not Available', :percent=>row[15].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Hawaiian Pacific', :percent=>row[16].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'White', :percent=>row[17].to_f)
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
        	    Enrollment.create(:school_id=>school.id, :year_from=>1999, :year_to=>2000, :count=>row[30].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2000, :year_to=>2001, :count=>row[31].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2001, :year_to=>2002, :count=>row[32].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2002, :year_to=>2003, :count=>row[33].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2003, :year_to=>2004, :count=>row[34].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2004, :year_to=>2005, :count=>row[35].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2005, :year_to=>2006, :count=>row[36].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2006, :year_to=>2007, :count=>row[37].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2007, :year_to=>2008, :count=>row[38].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2008, :year_to=>2009, :count=>row[39].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2009, :year_to=>2010, :count=>row[40].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2010, :year_to=>2011, :count=>row[41].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2011, :year_to=>2012, :count=>row[42].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2012, :year_to=>2013, :count=>row[43].to_i)
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
end


