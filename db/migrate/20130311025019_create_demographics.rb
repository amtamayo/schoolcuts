class CreateDemographics < ActiveRecord::Migration
  def change
    create_table :demographics do |t|
      t.integer :school_id
      t.integer :year_from
      t.integer :year_to
      t.string :category
      t.float :percent

      t.timestamps
    end
  end
end
