class ModifySchool < ActiveRecord::Migration
  def up
  	add_column :schools, :phone, :string
  	add_column :schools, :level, :string
  	add_column :schools, :zip, :integer
  end

  def down
  	remove_column :schools, :phone
  	remove_column :schools, :level
  	remove_column :schools, :zip
  end
end
