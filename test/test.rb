require "test/unit"
require_relative '../models/checkout'

class CheckoutTest < Test::Unit::TestCase
  def init
    co = Checkout.new
    co.init(true)
  end

  def test_3atv_1vga
    init
    input_items = ['atv', 'atv', 'atv', 'vga']
    assert_equal 249.00, Checkout.calculate(input_items), "3 atv + 1 vga should equal 249"
  end

  def test_5atv_1vga
    init
    input_items = ['atv', 'atv', 'atv', 'atv', 'atv', 'vga']
    assert_equal 468, Checkout.calculate(input_items), "5 atv + 1 vga should equal 468"
  end

  def test_2atv_5ipd
    init
    input_items = ['atv', 'atv', 'ipd', 'ipd', 'ipd', 'ipd', 'ipd']
    assert_equal 2718.95, Checkout.calculate(input_items), "2 atv + 5 ipd should equal 2718.95"
  end

  def test_2mbp_2vga_1ipd
    init
    input_items = ['mbp', 'mbp', 'vga', 'vga']
    assert_equal 2799.98, Checkout.calculate(input_items), "2 mbp + 2 vga should equal 2799.98"
  end

  def test_6vga_5ipd
    init
    input_items = [
      'vga', 'vga', 'vga', 'vga', 'vga', 'vga',
      'ipd', 'ipd', 'ipd', 'ipd', 'ipd'
    ]
    assert_equal 2679.95, Checkout.calculate(input_items), "6 vga + 5 ipd should equal 2679.95"
  end

  def test_1vga_1ipd_1ipd_1mbp
    init
    input_items = [
      'mbp', 'ipd',
      'vga', 'atv'
    ]
    assert_equal 2059.48, Checkout.calculate(input_items), "1 vga + 1 ipd + 1mbp + 1 atv should equal 2059.48"
  end
end


