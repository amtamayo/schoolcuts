class ChangeSchoolLevelToInteger < ActiveRecord::Migration
  include ImportHelper

  def up
    rename_column :schools, :level, :level_string
    add_column :schools, :level, :integer
    School.all.each do |school|
      school.update_attribute(:level, parse_level(school.level_string.to_s))
    end
    remove_column :schools, :level_string
  end

  def down
    rename_column :schools, :level, :level_integer
    add_column :schools, :level, :string
    School.all.each do |school|
      school.update_attribute(:level, "Level #{school.level_integer}") if school.level_integer
    end
    remove_column :schools, :level_integer
  end

end
