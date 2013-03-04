#!/usr/bin/env ruby 


require 'csv'

inputfile = "schools.csv"

list = CSV.read(inputfile, :headers => true )

puts "List of Schools"
#list.each { | row | puts row[0].to_s + " " + row[1].to_s }
row = list.first
School.Create(
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

#list.each { | row | 
			#puts row[0].to_s + " " + row[1].to_s
			#puts ":access_type, #{row[9].to_s}"
			#puts ":community_area, #{row[5].to_s}"
			#puts ":cps_id, #{row[0].to_s}"
			#puts ":full_name, #{row[3].to_s}"
			#puts ":latitude, #{row[6].to_s}"
			#puts ":longitude, #{row[7].to_s}"
			#puts ":school_type, #{row[8].to_s}"
			#puts ":short_name, #{row[1].to_s}"
			#puts ":street_address,#{row[4].to_s}"
			
			
#		}