class AddIndexToMapLegends < ActiveRecord::Migration
  def change
    add_index :map_legends, :school_id
  end
end
