class AddIsatUrl < ActiveRecord::Migration
  def up
  	add_column :schools, :isat_url, :string
  end

  def down
  	remove_column :schools, :isat_url
  end
end
