require 'bigdecimal'

class ShoppingBucketParser
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