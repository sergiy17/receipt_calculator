require 'bigdecimal'

class TaxCalculator
  # @param product_name [String] Product's name
  # @param price [BigDecimal] Product's price
  # @param quantity [Integer] Product's quantity
  # @return [BigDecimal] Calculated product's tax

  EXEMPT_PRODUCTS = %w[book chocolate pills].freeze
  IMPORTED_PRODUCTS = %w[imported].freeze
  ROUNDING_FACTOR = 20

  def self.calculate(product_name, price, quantity)
    intermediate_tax = tax_rate(product_name) * price / 100
    rounded_intermediate_tax = round_to_nearest_5_cents(intermediate_tax)
    final_tax = rounded_intermediate_tax * quantity
    final_tax
  end

  private

  def self.tax_rate(product_name)
    base_tax = 10
    base_tax = 0 if EXEMPT_PRODUCTS.any? { |word| product_name.include?(word) }
    base_tax += 5 if IMPORTED_PRODUCTS.any? { |word| product_name.include?(word) }
    BigDecimal(base_tax.to_s)
  end

  def self.round_to_nearest_5_cents(value)
    BigDecimal(((value * ROUNDING_FACTOR).ceil.to_f / ROUNDING_FACTOR).to_s)
  end
end
