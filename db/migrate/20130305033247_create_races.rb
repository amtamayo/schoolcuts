class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.integer :school_id
      t.string :ethnicity
      t.float :percent

      t.timestamps
    end
  end
end
