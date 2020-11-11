require "minitest/autorun"
require "minitest/pride"
require "./lib/vendor.rb"
require "./lib/item.rb"
require "mocha/minitest"

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

  def test_it_has_restock_times
    t1 = Time.at(628232401)
    Time.stubs("new").returns(t1)
    @vendor.stock(@item1,30)
    t2 = Time.at(628232403)
    Time.stubs("new").returns(t2)
    @vendor.stock(@item1,25)
    @vendor.stock(@item2,12)
    expected = {
      @item1 => t1,
      @item2 => t2,
    }
    assert_equal expected, @vendor.restock_times
  end

  def test_it_can_sell
    t1 = Time.at(628232401)
    Time.stubs("new").returns(t1)
    @vendor.stock(@item1,25)

    t2 = Time.at(628232403)
    Time.stubs("new").returns(t2)
    @vendor.stock(@item2,12)

    assert_equal true, @vendor.restock_times[@item1] < @vendor.restock_times[@item2]

    assert_equal 25, @vendor.sell(@item1,50)
    assert_equal 10, @vendor.sell(@item2,10)

    assert_equal 0, @vendor.check_stock(@item1)
    assert_equal 2, @vendor.check_stock(@item2)

    t3 = Time.at(628232405)
    Time.stubs("new").returns(t3)
    @vendor.stock(@item1,1)

    t4 = Time.at(628232408)
    Time.stubs("new").returns(t4)
    @vendor.stock(@item2,1)

    assert_equal false, @vendor.restock_times[@item1] < @vendor.restock_times[@item2]

  end
end
