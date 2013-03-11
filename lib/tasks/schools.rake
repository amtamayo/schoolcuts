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
					:access_type => row[10].to_s,
					:community_area => row[6].to_s,
					:cps_id => row[0].to_i,
					:full_name => row[2].to_s,
					:latitude => row[7].to_f,
					:level => row[11].to_s,
					:longitude => row[8].to_f,
					:phone => row[3].to_s,
					:school_type => row[9].to_s,
					:short_name => row[1].to_s,
					:street_address => row[4].to_s,
					:zip => row[5].to_i
				)
			else
				school.access_type = row[10].to_s
				school.community_area = row[6].to_s
				school.cps_id = row[0].to_i
				school.full_name = row[2].to_s
				school.latitude = row[7].to_f
				school.level = row[11].to_s
				school.longitude = row[8].to_f
				school.phone = row[3].to_s
				school.school_type = row[8].to_s
				school.short_name = row[1].to_s
				school.street_address = row[4].to_s
				school.zip = row[5].to_i
				school.save
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
				Mobility.create(:school_id=>school.id, :year_from=>1999, :year_to=>2000, :rate=>row[75].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2000, :year_to=>2001, :rate=>row[76].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2001, :year_to=>2002, :rate=>row[77].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2002, :year_to=>2003, :rate=>row[78].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2003, :year_to=>2004, :rate=>row[79].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2004, :year_to=>2005, :rate=>row[80].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2005, :year_to=>2006, :rate=>row[81].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2006, :year_to=>2007, :rate=>row[82].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2007, :year_to=>2008, :rate=>row[83].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2008, :year_to=>2009, :rate=>row[84].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2009, :year_to=>2010, :rate=>row[85].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2010, :year_to=>2011, :rate=>row[86].to_f)
				Mobility.create(:school_id=>school.id, :year_from=>2011, :year_to=>2012, :rate=>row[87].to_f)
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
        	    Enrollment.create(:school_id=>school.id, :year_from=>1999, :year_to=>2000, :count=>row[32].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2000, :year_to=>2001, :count=>row[33].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2001, :year_to=>2002, :count=>row[34].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2002, :year_to=>2003, :count=>row[35].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2003, :year_to=>2004, :count=>row[36].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2004, :year_to=>2005, :count=>row[37].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2005, :year_to=>2006, :count=>row[38].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2006, :year_to=>2007, :count=>row[39].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2007, :year_to=>2008, :count=>row[40].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2008, :year_to=>2009, :count=>row[41].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2009, :year_to=>2010, :count=>row[42].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2010, :year_to=>2011, :count=>row[43].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2011, :year_to=>2012, :count=>row[44].to_i)
        	    Enrollment.create(:school_id=>school.id, :year_from=>2012, :year_to=>2013, :count=>row[45].to_i)
        	else
        	 	puts "School #{row[1].to_s} not found"
            end
        }
    end

    desc "import essential"
    task :import_essential => :environment do
    	inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"
    	
    	Essential.delete_all()
    	
    	list = CSV.read(inputfile, :headers => true)
    	list.each {|row|
    		school = School.find_by_cps_id(row[0].to_i)
    		if(!school.nil?)
    			puts "Essential for #{row[0].to_s} #{row[1].to_s}"
    			Essential.create(:school_id=>school.id, :category=>'instruction', :year_from=>2010, :year_to=>2011 , :rating=>row[127].to_s)
    			Essential.create(:school_id=>school.id, :category=>'instruction', :year_from=>2011, :year_to=>2012 , :rating=>row[128].to_s)
    			Essential.create(:school_id=>school.id, :category=>'leaders', :year_from=>2010, :year_to=>2011 , :rating=>row[129].to_s)
    			Essential.create(:school_id=>school.id, :category=>'leaders', :year_from=>2011, :year_to=>2012 , :rating=>row[130].to_s)
    			Essential.create(:school_id=>school.id, :category=>'teachers', :year_from=>2010, :year_to=>2011 , :rating=>row[131].to_s)
    			Essential.create(:school_id=>school.id, :category=>'teachers', :year_from=>2011, :year_to=>2012 , :rating=>row[132].to_s)
    			Essential.create(:school_id=>school.id, :category=>'families', :year_from=>2010, :year_to=>2011 , :rating=>row[133].to_s)
    			Essential.create(:school_id=>school.id, :category=>'families', :year_from=>2011, :year_to=>2012 , :rating=>row[134].to_s)
    			Essential.create(:school_id=>school.id, :category=>'environment', :year_from=>2010, :year_to=>2011 , :rating=>row[135].to_s)
    			Essential.create(:school_id=>school.id, :category=>'environment', :year_from=>2011, :year_to=>2012 , :rating=>row[136].to_s)
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
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2006, :year_to=>2007, :percent=>row[89].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2007, :year_to=>2008, :percent=>row[90].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2008, :year_to=>2009, :percent=>row[91].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2009, :year_to=>2010, :percent=>row[92].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2010, :year_to=>2011, :percent=>row[93].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>2011, :year_to=>2012, :percent=>row[94].to_f)
				
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2006, :year_to=>2007, :percent=>row[101].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2007, :year_to=>2008, :percent=>row[102].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2008, :year_to=>2009, :percent=>row[103].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2009, :year_to=>2010, :percent=>row[104].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2010, :year_to=>2011, :percent=>row[105].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>2011, :year_to=>2012, :percent=>row[106].to_f)
		
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2006, :year_to=>2007, :percent=>nil)
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2007, :year_to=>2008, :percent=>row[113].to_f)
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2008, :year_to=>2009, :percent=>nil)
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2009, :year_to=>2010, :percent=>nil)
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2010, :year_to=>2011, :percent=>row[114].to_f)				
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2011, :year_to=>2012, :percent=>nil)
			else
				puts "School #{row[1].to_s} not found"
			end
		}
	end
    
    desc "import probation"
    task :import_probation => :environment do
        inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"

        Probation.delete_all()
        
        list = CSV.read(inputfile, :headers => true)
        list.each { |row|
        	school = School.find_by_cps_id(row[0].to_i)
        	if (!school.nil?)
        	    puts "Probation for #{row[0].to_s} #{row[1].to_s}"
        	    Probation.create(:school_id=>school.id, :year_from=>1996, :year_to=>1997, :status=>row[74].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>1997, :year_to=>1998, :status=>row[73].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>1998, :year_to=>1999, :status=>row[72].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>1999, :year_to=>2000, :status=>row[71].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2000, :year_to=>2001, :status=>row[70].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2001, :year_to=>2002, :status=>row[69].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2002, :year_to=>2003, :status=>row[68].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2003, :year_to=>2004, :status=>row[67].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2004, :year_to=>2005, :status=>row[66].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2005, :year_to=>2006, :status=>row[65].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2006, :year_to=>2007, :status=>row[64].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2007, :year_to=>2008, :status=>row[63].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2008, :year_to=>2009, :status=>row[62].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2009, :year_to=>2010, :status=>row[61].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2010, :year_to=>2011, :status=>row[60].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2011, :year_to=>2012, :status=>row[59].to_s)
        	    Probation.create(:school_id=>school.id, :year_from=>2012, :year_to=>2013, :status=>row[58].to_s)
        	else
        	 	puts "School #{row[1].to_s} not found"
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
				Race.create(:school_id=>school.id, :ethnicity=>'Asian', :percent=>row[12].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Black', :percent=>row[13].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Hispanic', :percent=>row[14].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Multi-racial', :percent=>row[15].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Native American', :percent=>row[16].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Not Available', :percent=>row[17].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'Hawaiian Pacific', :percent=>row[18].to_f)
				Race.create(:school_id=>school.id, :ethnicity=>'White', :percent=>row[19].to_f)
			else
				puts "School #{row[1].to_s} not found"
			end
		}
		
	end
	
	desc "import utilization"
	task :import_utilization => :environment do
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"
		Utilization.delete_all()
		
		list = CSV.read(inputfile, :headers => true)
		list.each { |row|
			school = School.find_by_cps_id(row[0].to_i)
			if (!school.nil?)
				puts "Importing utilization for #{row[1].to_s}"
				Utilization.create(:school_id=>school.id, :homerooms=>row[47].to_f, :other_rooms=>row[48].to_f, :year_from=>2012, :year_to=>2013)
			else
				puts "School #{row[1].to_s} not found"
			end
		}
	end
    
    desc "Import Demographics (Language, SPED, Low Income)"
	    task :import_demographics => :environment do

	    inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"

	    Demographic.delete_all()

	    list = CSV.read(inputfile, :headers => true)
	    list.each {|row|
		    puts row[0].to_s + row[21].to_s
		    school = School.find_by_cps_id(row[0])
		    if (!school.nil?)
			    Demographic.create(:school_id => school.id, :year_from => 2012, :year_to => 2013, :category => "Bilingual", :percent => row[21].to_f)
			    Demographic.create(:school_id => school.id, :year_from => 2012, :year_to => 2013, :category => "SPED", :percent => row[25].to_f)
			    Demographic.create(:school_id => school.id, :year_from => 2012, :year_to => 2013, :category => "Low Income", :percent => row[29].to_f)
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
    	Rake::Task['cps:import_enrollment'].invoke
    	Rake::Task['cps:import_essential'].invoke
    	Rake::Task['cps:import_isat_score'].invoke
    	Rake::Task['cps:import_mobility_rates'].invoke
    	Rake::Task['cps:import_probation'].invoke
    	Rake::Task['cps:import_race'].invoke
    	Rake::Task['cps:import_utilization'].invoke
    	Rake::Task['cps:import_demographics'].invoke
    end
end


