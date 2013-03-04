class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.integer :cps_id
      t.string :short_name
      t.string :full_name
      t.float :latitude
      t.float :longitude
      t.string :street_address
      t.string :community_area
      t.string :school_type
      t.string :access_type

      t.timestamps
    end
  end
end
