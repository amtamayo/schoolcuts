# Installation

## Requirements
1. Ruby / Ruby on Rails
2. Bundler
3. PostgreSQL

## Set up
1. `bundle` to install gem dependencies
2. start postgres
3. `rake db:create` to create the database
4. `rake db:migrate` to create the database tables
5. `rake cps:import_all` to import data from CSV files in `lib/tasks/data`
6. `rails server` to start the rails server

You should now be able to visit [http://localhost:3000][1] and see a working local copy of the site.

[1]: http://localhost:3000