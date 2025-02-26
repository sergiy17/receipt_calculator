require_relative '../../lib/shopping_bucket_parser'
require 'rspec'
require 'debug'

RSpec.describe ShoppingBucketParser do
  subject(:result) { described_class.parse(input) }

  describe '.parse' do
    let(:input) do
      <<~INPUT
        2 book at 12.49
        1 music CD at 14.99
        1 chocolate bar at 0.85
        3 imported boxes of chocolates at 11.25
      INPUT
    end

    let(:parsed_output) do
      [
        { quantity: 2, product_name: "book", price: BigDecimal('12.49') },
        { quantity: 1, product_name: "music CD", price: BigDecimal('14.99') },
        { quantity: 1, product_name: "chocolate bar", price: BigDecimal('0.85') },
        { quantity: 3, product_name: "imported boxes of chocolates", price: BigDecimal('11.25') }
      ]
    end

    it 'correctly parses the shopping bucket' do
      expect(result).to match_array(parsed_output)
    end
  end
end
