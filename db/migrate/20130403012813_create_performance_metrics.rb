class CreatePerformanceMetrics < ActiveRecord::Migration
  def change
    create_table :performance_metrics do |t|
      t.integer :school_id
      t.float :policy_points
      t.float :isat_composite
      t.float :value_added_math
      t.float :value_added_reading

      t.timestamps
    end
  end
end
