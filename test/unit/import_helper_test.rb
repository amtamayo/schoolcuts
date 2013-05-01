require 'test_helper'

class ImportHelperTest < ActiveSupport::TestCase
  include ImportHelper

  test "parse_level should return integer level value" do
    assert_equal 5, parse_level("Level 5") 
  end
  
  test "parse_level should return nil if level value is invalid" do
    assert_nil  parse_level("Not Enough Information") 
    assert_nil  parse_level("N/A") 
  end
end
