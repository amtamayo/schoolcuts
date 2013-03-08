class ModifyEssential < ActiveRecord::Migration
  def up
  	add_column :essentials, :year_from, :integer
  	add_column :essentials, :year_to, :integer
  end

  def down
  	remove_column :essentials, :year_from
  	remove_column :essentials, :year_to
  end
end
