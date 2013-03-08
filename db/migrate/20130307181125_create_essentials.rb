class CreateEssentials < ActiveRecord::Migration
  def change
    create_table :essentials do |t|
      t.integer :school_id
      t.string :category
      t.string :rating

      t.timestamps
    end
  end
end
