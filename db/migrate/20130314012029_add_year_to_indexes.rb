class AddYearToIndexes < ActiveRecord::Migration
  def change
    add_index :utilizations, :year_to
    add_index :enrollments,  :year_to
  end
end
