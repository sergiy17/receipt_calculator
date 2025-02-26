require_relative '../lib/tax_calculator'

class ReceiptItem
  attr_reader :quantity, :product_name, :price

  # @param quantity [Integer] Item quantity
  # @param product_name [String] Product's name
  # @param price [BigDecimal] Product's price
  def initialize(quantity:, product_name:, price:)
    @quantity = quantity
    @product_name = product_name
    @price = price
  end

  # @return [BigDecimal] The final item's price
  def final_price
    price * quantity + total_tax
  end

  # @return [BigDecimal] The item's total tax
  def total_tax
    TaxCalculator.calculate(product_name, price, quantity)
  end

  # @return [String] Formatted receipt line
  def to_receipt_line
    format('%i %s: %.2f', quantity, product_name, final_price.to_s('F'))
  end
end
