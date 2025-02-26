require_relative '../lib/tax_calculator'

class ReceiptItem
  attr_reader :quantity, :product_name, :price

  def initialize(quantity:, product_name:, price:)
    @quantity = quantity
    @product_name = product_name
    @price = price
  end

  def final_price
    (price * quantity + total_tax).round(2, BigDecimal::ROUND_HALF_UP)
  end

  def total_tax
    TaxCalculator.calculate(product_name, price, quantity)
  end

  def to_receipt_line
    format('%i %s: %.2f', quantity, product_name, final_price.to_s('F'))
  end
end
