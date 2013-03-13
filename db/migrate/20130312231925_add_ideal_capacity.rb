class AddIdealCapacity < ActiveRecord::Migration
  def up
  	add_column :utilizations, :ideal_capacity, :integer
  end

  def down
  	remove_column :utilizations, :ideal_capacity
  end
end
