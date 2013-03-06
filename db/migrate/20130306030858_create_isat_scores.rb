class CreateIsatScores < ActiveRecord::Migration
  def change
    create_table :isat_scores do |t|
      t.integer :school_id
      t.integer :year_from
      t.integer :year_to
      t.string :subject
      t.float :percent

      t.timestamps
    end
  end
end
