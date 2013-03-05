#!/usr/bin/env ruby 


require 'csv'

inputfile = "schools.csv"

list = CSV.read(inputfile, :headers => true )
list.headers.each{ |h| puts h }
