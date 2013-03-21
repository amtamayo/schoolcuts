class CreateSchoolDistances < ActiveRecord::Migration
  def change
    create_table :school_distances do |t|
      t.integer :from_school_id
      t.string :to_school_id
      t.float :distance

      t.timestamps
    end
  end
end
