require 'csv'

namespace :cps do
	desc "import school data"
	task :import_schools => :environment do
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"

		list = CSV.read(inputfile, :headers => true )
		
		list.each { | row | 
			puts "#{row[0]} #{row[1]} #{row[137]}"
			school = School.find_by_cps_id(row[0].to_i)
			
			puts "#{row[137]}"
			closing_status = row[137].nil? ? nil : row[137].to_i
			receiving_status = row[138].nil? ? nil : row[138].to_i
				
			if school.nil?
				
				school = School.create(
					:access_type => row[10].to_s,
					:community_area => row[6].to_s,
					:cps_id => row[0].to_i,
					:full_name => row[2].to_s,
					:level => row[11].to_s,
					:phone => row[3].to_s,
					:school_type => row[9].to_s,
					:short_name => row[1].to_s,
					:isat_url =>row[88].to_s,
					:closing_status => closing_status
					:receiving_status => receiving_status 
				)
				
				address = Address.create(
					:street_address => row[4].to_s,
					:zipcode => row[5].to_s,
					:latitude => row[7].to_f,
					:longitude => row[8].to_f
				)
				
				if (!address.nil? && !school.nil?)
					school_address = SchoolAddress.create(
						:school_id => school.id,
						:address_id => address.id,
						:year_from => 2012,
						:year_to => 2013
					)
				end
			else
				school.access_type = row[10].to_s
				school.community_area = row[6].to_s
				school.cps_id = row[0].to_i
				school.full_name = row[2].to_s
				school.level = row[11].to_s
				school.phone = row[3].to_s
				school.school_type = row[9].to_s
				school.short_name = row[1].to_s
				school.isat_url = row[88].to_s,
				school.closing_status = closing_status  
				school.receiving_status = receiving_status
				school.save

				
				
				school_address = school.school_addresses.where("year_from = 2012").first
				if (!school_address.nil?)
					address = school_address.address
					
					address.street_address = row[4].to_s
					address.zipcode = row[5].to_s
					address.latitude = row[7].to_f
					address.longitude = row[8].to_f
				end
			
			end
			
			school.short_name = school.short_name.downcase.split(' ').map {|w| w.capitalize }.join(' ')
			school.save
			
		}
	end
	
	desc "import mobility rates"
	task :import_mobility_rates => :environment do
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schools.csv"
		
		Mobility.delete_all()
		
		list = CSV.read(inputfile, :headers => true)
		
		list.each { |row|
			school = School.find_by_cps_id(row[0].to_i)
			year_from = 1999
			if(!school.nil?)
				(75..87).map{|i| 
					rate=nil				 
					if !(row[i]=="" || row[i].nil?) 
						rate=row[i].to_f 
					end
					puts "Importing mobility rates for #{i.to_s}: #{row[1].to_s} => #{rate.to_s}"
					Mobility.create(:school_id=>school.id, :year_from=>year_from, :year_to=>year_from+1, :rate=>rate)
					year_from = year_from + 1
				}
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
	        	year_from=1999
        		(32..45).map{ |i|
        			count=nil
        			if !(row[i].nil? || row[0]=="")
        				count=row[i].to_i
        			end
					puts "Importing enrollment for #{year_from.to_s}: #{row[1].to_s} => #{count}"
        			Enrollment.create(:school_id=>school.id, :year_from=>year_from, :year_to=>year_from+1, :count=>count)
        			year_from = year_from + 1
        		}
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
				year_from=2006
				puts "Reading"
				(89..94).map{ |i|
					count=nil
					puts "Importing ISAT scores for #{row[i]}"
					if !(row[i].nil?)
						count=row[i].to_f
					end
					IsatScore.create(:school_id=>school.id, :subject=>'Reading', :year_from=>year_from, :year_to=>year_from+1, :percent=>count)
					year_from = year_from + 1
				}

				year_from=2006
				puts "Math"
				(101..106).map{ |i|
					count=nil
					puts "Importing ISAT scores for #{row[i]}"
					if !(row[i].nil?)
						count=row[i].to_f
					end
					IsatScore.create(:school_id=>school.id, :subject=>'Math', :year_from=>year_from, :year_to=>year_from+1, :percent=>count)
					year_from = year_from + 1
				}
				year_from=2006
				puts "Science"
				
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2006, :year_to=>2007, :percent=>nil)
				count=nil
				if !(row[113].nil?)
					count=row[113].to_f
				end
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2007, :year_to=>2008, :percent=>count)
				
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2008, :year_to=>2009, :percent=>nil)
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2009, :year_to=>2010, :percent=>nil)
				
				count=nil
				if !(row[114].nil?)
					count=row[114].to_f
				end
				IsatScore.create(:school_id=>school.id, :subject=>'Science', :year_from=>2010, :year_to=>2011, :percent=>count)				
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
				Utilization.create(:school_id=>school.id, :homerooms=>row[47].to_f, :ideal_capacity=>row[49].to_i, :other_rooms=>row[48].to_f, :year_from=>2012, :year_to=>2013)
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
			    Demographic.create(:school_id => school.id, :year_from => 2012, :year_to => 2013, :category => "Bilingual", :percent => row[20].to_f)
			    Demographic.create(:school_id => school.id, :year_from => 2012, :year_to => 2013, :category => "Special Education", :percent => row[24].to_f)
			    Demographic.create(:school_id => school.id, :year_from => 2012, :year_to => 2013, :category => "Low Income", :percent => row[28].to_f)
		    end	
	    }
    end
    
    desc "Import school distances"
    task :import_school_distances => :environment do
    	inputfile = "#{Rails.root.to_s}/lib/tasks/data/schooldistances.csv"
    	list  = CSV.read(inputfile, :headers => true )
    	list.each{ |row|
    		school = School.find_by_cps_id(row[0])
    		to_school = School.find_by_cps_id(row[1])
    		if (!school.nil? & !to_school.nil?)
    		
    			SchoolDistance.create(:from_school_id => school.id, :to_school_id => to_school.id, :distance => row[2].to_i)
    			#puts "#{row[0]} -> #{row[1]} is #{row[2]} feet apart"
    		end
    	}
    	puts "School distances import completed"
    end

    desc "import action types"
	task :import_actions => :environment do
		puts "Importing action types"
		Action.delete_all
		
		Action.create(:action_code => 1, :name=>"considered but not closing")
		Action.create(:action_code => 2, :name=>"closing")
		Action.create(:action_code => 3, :name=>"turnaround")
		Action.create(:action_code => 4, :name=>"relocating")
		Action.create(:action_code => 5, :name=>"co-locating")
		Action.create(:action_code => 6, :name=>"closing grades 9 to 11")
		Action.create(:action_code => 7, :name=>"phasing out over 2 years")
		Action.create(:action_code => 8, :name=>"not considered but will be turnaround")
    end
    
    desc "import school actions"
	task :import_school_actions => :environment do
		puts "Importing school actions"
		
		SchoolAction.delete_all
		inputfile = "#{Rails.root.to_s}/lib/tasks/data/schoolActions.csv"
		
		list = CSV.read(inputfile, :headers => true )
		list.each{ |row|
    		school = School.find_by_cps_id(row[0])
    		to_school = School.find_by_cps_id(row[2])
    		if (!school.nil? & !to_school.nil?)
    		
    			SchoolAction.create(:school_id => school.id, :result_id => to_school.id, :action_id => row[1].to_i + 1)
    			#puts "#{row[0]} -> #{row[1]} -> #{row[2]} "
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
    	Rake::Task['cps:import_actions'].invoke
    	Rake::Task['cps:import_school_actions'].invoke

    end
end


