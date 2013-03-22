class RemoveAddressFromSchools < ActiveRecord::Migration
  def up
  	remove_column :schools, :street_address
  	remove_column :schools, :zip
  	remove_column :schools, :latitude
  	remove_column :schools, :longitude
  	
  end

  def down
  	add_column :schools, :street_address, :string
  	add_column :schools, :zip, :integer
  	add_column :schools, :latitude, :float
  	add_column :schools, :longitude, :float
  end

  def down
  end
end
