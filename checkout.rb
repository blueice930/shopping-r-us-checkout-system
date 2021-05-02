require_relative 'initialization'
require_relative 'command_handler'

class Checkout
  include Initialization

  @@env = {}
  @@price_list = {}
  @@discount_rule_list = {}
  @@rule_map = {
    "XFORY" => :x_for_y,
    "SUBTRACT_PRICE" => :subtract_price,
    "BUNDLE" => :for_free,
    "NONE" => :no_discount
  }

  def self.get_env
    @@env
  end

  def self.get_price
    @@price_list
  end

  def self.get_discounts
    @@discount_rule_list
  end

  def self.calculate(items)
    original_sub = parse_items(items)
    subtotal_with_discount = apply_rules_to(original_sub)
    total = calc_total(subtotal_with_discount)
    total
  end

  def self.parse_items(items)
    items&.tally.map { |item, amount| [item, { 'amount' =>  amount, 'price' => @@price_list[item] }] }.to_h
    # Data structure example:
    # items: {
    #   item_name: {
    #     amount: 123,
    #     price: 13.99
    #   },
    #   ...
    # } 
  end

  def self.apply_rules_to(sub)
    new_sub = sub
    new_sub.each do |item, props|
      # filter out appliable discount
      discounts = get_discount_for(item, props)
      discounts.each do |disc|
        new_sub = apply_discount(disc, new_sub)
      end
    end
    new_sub
  end

  def self.apply_discount(discount, items_data)
    new_items_data = items_data
    type = discount['discount_type']
    affected_item = get_affected_item(discount)
    unless @@rule_map[type].nil?
      # map with different discount func
      new_items_data[affected_item] = self.send(@@rule_map[type], discount['detail'], items_data[affected_item])
    end
    new_items_data
  end

  def self.get_discount_for(item, props)
    @@discount_rule_list.select do |rule|
      rule_is_triggered = props['amount'] >= rule['detail']['trigger_amount']
      rule["item"] == item && rule_is_triggered
    end
  end

  def self.get_affected_item(rule)
    rule['discount_type'] == 'BUNDLE' ? rule['detail']['addon'] : rule['item']
  end

  def self.x_for_y(detail, item)
    new_item = item
    trigger_amount = detail['trigger_amount']
    discount_amount = detail['discount_amount']
    amount = item['amount']
    if amount >= trigger_amount
      new_item['amount'] = amount - (amount / trigger_amount)
    end
    new_item
  end

  def self.subtract_price(detail, item)
    new_item = item
    trigger_amount = detail['trigger_amount']
    discount_amount = detail['discount_amount']
    amount = item['amount']
    price = item['price']
    if amount >= trigger_amount
      new_item['price'] = price - discount_amount
    end
    new_item
  end

  def self.for_free(detail, item)
    new_item = item
    trigger_amount = detail['trigger_amount']
    discount_amount = detail['discount_amount']
    addon = detail['addon']
    amount = item['amount']
    if amount >= 0
      new_item['amount'] = amount - discount_amount
    end
    new_item
  end

  def self.calc_total(sub)
    total = 0
    sub.reduce(0) do |sum, item|
      amount = item[1]['amount']
      price = item[1]['price']
      sum += amount * price
    end
  end
end
