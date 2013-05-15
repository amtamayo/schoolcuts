class CreateMapLegends < ActiveRecord::Migration
  def change
    create_table :map_legends do |t|
      t.integer :school_id
      t.string :marker
      t.text :description

      t.timestamps
    end
  end
end
