class CreateSchoolAddresses < ActiveRecord::Migration
  def change
    create_table :school_addresses do |t|
      t.integer :school_id
      t.integer :address_id
      t.integer :year_from
      t.integer :year_to

      t.timestamps
    end
    add_index :school_addresses, :year_from
    add_index :school_addresses, :year_to
  end
end
