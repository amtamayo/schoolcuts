class AddResultCodeToSchoolActions < ActiveRecord::Migration
  def up
    add_column :school_actions, :result_code, :integer
  end
  
  def down
  	remove_column :school_actions, :result_code
  end

end
