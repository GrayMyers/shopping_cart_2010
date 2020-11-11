class Vendor
  attr_reader :name, :inventory, :restock_times
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
    @restock_times = {}
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, amount)
    if @inventory[item] == 0
      @restock_times[item] = Time.new
    end
    @inventory[item] += amount
  end

  def potential_revenue
    @inventory.sum do |item,amount|
      item.price * amount
    end
  end

  def sell(item,amount)
    stock = check_stock(item)
    if amount >= stock
      @restock_times.delete(item)
      @inventory.delete(item)
      stock
    else
      @inventory[item] -= amount
      amount
    end
  end
end
