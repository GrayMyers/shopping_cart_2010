require "minitest/autorun"
require "minitest/pride"
require "./lib/market.rb"
require "./lib/vendor.rb"
require "./lib/item.rb"

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})

    @item2 = Item.new({name: 'Tomato', price: "$0.50"})

    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})

    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @vendor1.stock(@item1, 35)

    @vendor1.stock(@item2, 7)

    @vendor2 = Vendor.new("Ba-Nom-a-Nom")

    @vendor2.stock(@item4, 50)

    @vendor2.stock(@item3, 25)

    @vendor3 = Vendor.new("Palisade Peach Shack")

    @vendor3.stock(@item1, 65)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Market, @market

    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal ([]), @market.vendors
  end

  def test_it_can_add_vendor
    assert_equal ([]), @market.vendors
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    assert_equal ([@vendor1,@vendor2,@vendor3]), @market.vendors
  end

  def test_it_has_vendor_names
    assert_equal ([]), @market.vendor_names
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    assert_equal (["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]), @market.vendor_names
  end
end