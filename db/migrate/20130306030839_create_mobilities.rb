class CreateMobilities < ActiveRecord::Migration
  def change
    create_table :mobilities do |t|
      t.integer :school_id
      t.integer :year_from
      t.integer :year_to
      t.float :rate

      t.timestamps
    end
  end
end
