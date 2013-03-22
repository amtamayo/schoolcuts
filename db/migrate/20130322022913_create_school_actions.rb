class CreateSchoolActions < ActiveRecord::Migration
  def change
    create_table :school_actions do |t|
      t.integer :school_id
      t.integer :action_id
      t.integer :result_id

      t.timestamps
    end
  end
end
