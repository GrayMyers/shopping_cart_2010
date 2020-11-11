require "minitest/autorun"
require "minitest/pride"
require "./lib/vendor.rb"
require "./lib/item.rb"

class Test < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Vendor, @vendor

    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_it_can_check_stock_for_items
    assert_equal 0, @vendor.check_stock(@item1)
  end
end
