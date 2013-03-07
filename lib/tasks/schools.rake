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
	
	desc "import mobility rates"
	task :import_mobility_rates => :environment do
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"
		
		Mobility.delete_all()
		
		list = CSV.read(inputfile, :headers => true)
		list.each { |row|
			school = School.find_by_cps_id(row[0].to_i)
			if(!school.nil?)
				puts "Mobility for 1999-2000 #{row[0].to_s} #{row[65].to_s}"
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


