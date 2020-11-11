require "minitest/autorun"
require "minitest/pride"
require "./lib/vendor.rb"
require "./lib/item.rb"

class VendorTest < Minitest::Test
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

  def test_it_can_stock_item
    assert_equal 0, @vendor.check_stock(@item1)
    assert_equal ({}), @vendor.inventory
    @vendor.stock(@item1,30)
    @vendor.stock(@item1,25)
    assert_equal 55, @vendor.check_stock(@item1)
    assert_equal ({@item1 => 55}), @vendor.inventory
  end

  def test_it_has_potential_revenue
    assert_equal 0, @vendor.potential_revenue
    @vendor.stock(@item1,30)
    @vendor.stock(@item1,25)
    @vendor.stock(@item2,12)
    assert_equal 47.25, @vendor.potential_revenue 
  end
end
