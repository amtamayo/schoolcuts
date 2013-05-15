class CreateReceivingActions < ActiveRecord::Migration
  def change
    create_table :receiving_actions do |t|
      t.string :name
      t.integer :receiving_code

      t.timestamps
    end
  end
end
