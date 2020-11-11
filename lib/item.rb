class Item
  attr_reader :name

  def initialize(info_hash)
    @name = info_hash[:name]
    @price = info_hash[:price]
  end

  def price #manual attr_reader done for non-destructive formatting
    convert_price(@price)
  end

  def convert_price(price)
    price[0] = ""
    price.to_f
  end
end
