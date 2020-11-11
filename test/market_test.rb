require "minitest/autorun"
require "minitest/pride"
require "./lib/market.rb"

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Market, @market

    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal ([]), @market.vendors
  end
end
