class CreateProbations < ActiveRecord::Migration
  def change
    create_table :probations do |t|
      t.integer :school_id
      t.integer :year_from
      t.integer :year_to
      t.string :status

      t.timestamps
    end
  end
end
