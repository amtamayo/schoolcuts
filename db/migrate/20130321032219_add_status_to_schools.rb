class AddStatusToSchools < ActiveRecord::Migration
  def up
  	add_column :schools, :closing_status, :integer
  	add_column :schools, :receiving_status, :integer
  end

  def down
  	remove_column :schools, :closing_status
  	remove_column :schools, :receiving_status
  end

end
