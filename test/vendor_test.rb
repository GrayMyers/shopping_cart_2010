require "minitest/autorun"
require "minitest/pride"
require "./lib/vendor.rb"

class Test < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Vendor, @vendor

    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end
end
