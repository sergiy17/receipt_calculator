require 'bigdecimal'

class ShoppingBucketParser
  # @param input [String] Shopping bucket as a string
  # @return [Array<Hash>] An array of item hashes, where each hash contains:
  #   - :quantity [Integer] Items quantity
  #   - :product_name [String] Product's name
  #   - :price [BigDecimal] Product's price

  def self.parse(input)
    input.split("\n").map do |line|
      quantity, *product_name_parts, price_str = line.split(' ')
      product_name = product_name_parts[0...-1].join(' ') # remove price indicator "at "

      {
        quantity: quantity.to_i,
        product_name: product_name,
        price: BigDecimal(price_str)
      }
    end
  end
end