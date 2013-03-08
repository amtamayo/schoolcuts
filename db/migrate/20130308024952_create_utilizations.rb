class CreateUtilizations < ActiveRecord::Migration
  def change
    create_table :utilizations do |t|
      t.integer :school_id
      t.float :homerooms
      t.float :other_rooms
      t.integer :year_from
      t.integer :year_to

      t.timestamps
    end
  end
end
