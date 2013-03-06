class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :school_id
      t.integer :year_from
      t.integer :year_to
      t.integer :count

      t.timestamps
    end
  end
end
