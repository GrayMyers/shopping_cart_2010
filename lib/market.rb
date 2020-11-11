class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def total_inventory

  end

  def all_items
    all_item_hash = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item,amount|
        all_item_hash[item] += amount
      end
    end
    all_item_hash
  end

  def total_inventory
    all_items.map do |item,amount|
      info_hash = {
        quantity: amount,
        vendors: vendors_that_sell(item)
      }
      [item, info_hash]
    end.to_h
  end

  def overstocked_items
    all_items.find_all do |item,amount|
      (amount > 50) && (vendors_that_sell(item).count > 1)
    end.to_h.keys
  end

  def sorted_item_list
    all_items.keys.map do |item|
      item.name
    end.sort
  end

  def sell(item,amount)
    if not_enough(item,amount)
      return false
    end
    amount_to_sell = amount
    until amount_to_sell == 0 do
      first = first_vendor(item)
      stock = first.check_stock(item)
      amount_sold = first.sell(item,amount_to_sell) #set amount_sold to result of sale
      amount_to_sell -= amount_sold
    end
    true
  end

  def first_vendor(item)
    vendors_that_sell(item).min_by do |vendor|
      vendor.restock_times[item]
    end
  end

  def not_enough(item,amount)
    all_items[item] < amount
  end
end
