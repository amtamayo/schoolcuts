require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  should have_many :enrollments
  should have_many :essentials
  should have_many :isat_scores
  should have_many :map_legends
  should have_many :mobilities
  should have_many :probations
  should have_many :races
  should have_many :utilizations
  should have_many :demographics
  should have_many :school_addresses
  should have_many :school_actions
  should have_one :performance_metric

  context '#enrollments_for_year' do
    setup do
      enrollment_2000 = Enrollment.new(year_from: 2000, count: 30)
      enrollment_2001 = Enrollment.new(year_from: 2001, count: 35)
      @school = School.create
      @school.enrollments = [enrollment_2000, enrollment_2001]
      @school.save
    end

    should 'find the count of the matching enrollment' do
      assert_equal 35, @school.enrollments_for_year(2001)
    end

    should 'return 0 if there are no matching enrollments' do
      assert_equal 0, @school.enrollments_for_year(2009)
    end
  end
end

