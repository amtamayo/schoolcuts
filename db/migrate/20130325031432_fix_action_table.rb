class FixActionTable < ActiveRecord::Migration
  def up
  	add_column :actions, :action_code, :integer
  end

  def down
  	remove_column :actions, :action_code
  end
end
