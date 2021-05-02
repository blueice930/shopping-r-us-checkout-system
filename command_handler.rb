require 'io/console'
require_relative 'helper'

class CommandHandler
  include Helper

  @@cmd = ''
  @@ins_list = {
    'scan' => :scan_item, 's' => :scan_item,
    'quit' => :quit, 'q' => :quit,
    'price' => :list_price, 'p' => :list_price,
    'discount' => :list_discount, 'd' => :list_discount,
  }

  def perform
    init
    read_cmd
  end

  def init
    # Inialize price list, rules, and other env config.
    co = Checkout.new
    co.init
  end
  
  def read_cmd
    print_menu
    @@cmd = gets.chomp
    while invalid_cmd? @@cmd do
      puts @@cmd
      puts 'Invalid Command! Please enter again:'
      @@cmd = gets.chomp
    end
    handle @@cmd
  end

  def invalid_cmd?(cmd)
    @@ins_list[cmd].nil?
  end

  def handle(cmd)
    self.send(@@ins_list[cmd])
  end

  def quit
    puts "Program exit successuflly!"
    exit
  end

  def scan_item
    $stdout.clear_screen
    puts "SKUs Scanned: (separate with comma ',')"
    puts "Type q to go back to the menu"

    # Read scanned Items
    input = gets.chomp
    while !is_valid? input do
      puts 'Invalid items, Please Enter again.'
      input = gets.chomp
    end

    if input == 'q'
      self.read_cmd
    end
    items = input&.split(',').map(&:strip)

    price = Checkout.calculate(items)
    print_total(price)
  end

  def print_total(price)
    puts "Total expected: $#{'%.2f' % price}"
    go_back_to_menu
  end

  def list_discount
    Checkout.get_discounts.each_with_index do |discount, index|
      puts "Discount #{index+1}: #{discount.to_s}"
    end
    puts ""
    go_back_to_menu
  end

  def list_price
    Checkout.get_price.each do |item, price|
      puts "Item: #{item}, Price: $#{'%.2f' % price}"
    end
    puts ""
    go_back_to_menu
  end

  def go_back_to_menu
    puts "Press 'b' to go back to menu, any other keys to quit the program..."
    back = gets.chomp
    if back == 'b'
      self.read_cmd
    else
      quit
    end
  end

  private
  def is_valid?(input)
    return true if input == 'q'
    items = input&.split(',').map(&:strip)
    !items.any? { |item| Checkout.get_price[item].nil? }
  end
end
