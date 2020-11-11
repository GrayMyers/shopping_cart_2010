require "minitest/autorun"
require "minitest/pride"
require "./lib/item.rb"

class ItemTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Item, @item1

    assert_equal "Peach", @item1.name
  end

  def test_it_has_price
    assert_equal 0.75, @item1.price
  end

  def test_it_can_convert_price
    assert_equal 0.5, @item1.convert_price("$0.5")
    assert_equal 3.0, @item1.convert_price("$3.00")
  end
end
