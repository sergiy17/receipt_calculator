require_relative '../../lib/bucket_item'

require 'rspec'
require 'bigdecimal'
require 'debug'

RSpec.describe BucketItem do
  describe '#final_price' do
    it 'calculates the correct final price', :aggregate_failures do
      item = BucketItem.new(quantity: 1, product_name: 'music CD', price: BigDecimal('14.99'))
      expect(item.final_price).to eq(BigDecimal('16.49'))

      item = BucketItem.new(quantity: 2, product_name: 'book', price: BigDecimal('12.49'))
      expect(item.final_price).to eq(BigDecimal('24.98'))

      item = BucketItem.new(quantity: 1, product_name: 'imported bottle of perfume', price: BigDecimal('47.50'))
      expect(item.final_price).to eq(BigDecimal('54.65'))
    end

    it 'handles multiple quantities correctly' do
      item = BucketItem.new(quantity: 3, product_name: 'imported boxes of chocolates', price: BigDecimal('11.25'))
      expect(item.final_price).to eq(BigDecimal('35.55'))
    end

    it 'handles zero tax correctly' do
      item = BucketItem.new(quantity: 1, product_name: 'chocolate bar', price: BigDecimal('0.85'))
      expect(item.final_price).to eq(BigDecimal('0.85'))
    end
  end

  describe '#total_tax' do
    it 'calculates the correct tax for regular items' do
      item = BucketItem.new(quantity: 1, product_name: 'music CD', price: BigDecimal('14.99'))
      expect(item.total_tax).to eq(BigDecimal('1.50'))
    end

    it 'calculates zero tax for exempt items', :aggregate_failures do
      item = BucketItem.new(quantity: 2, product_name: 'book', price: BigDecimal('12.49'))
      expect(item.total_tax).to eq(BigDecimal('0.00'))

      item = BucketItem.new(quantity: 1, product_name: 'chocolate bar', price: BigDecimal('0.85'))
      expect(item.total_tax).to eq(BigDecimal('0.00'))

      item = BucketItem.new(quantity: 1, product_name: 'packet of headache pills', price: BigDecimal('9.75'))
      expect(item.total_tax).to eq(BigDecimal('0.00'))
    end

    it 'calculates the correct tax for imported items', :aggregate_failures do
      item = BucketItem.new(quantity: 1, product_name: 'imported bottle of perfume', price: BigDecimal('47.50'))
      expect(item.total_tax).to eq(BigDecimal('7.15'))

      item = BucketItem.new(quantity: 3, product_name: 'imported boxes of chocolates', price: BigDecimal('11.25'))
      expect(item.total_tax).to eq(BigDecimal('1.80'))
    end

    it 'handles rounding correctly', :aggregate_failures do
      item = BucketItem.new(quantity: 1, product_name: 'imported something', price: BigDecimal('1.01'))
      expect(item.total_tax).to eq(BigDecimal('0.20'))
    end
  end

  describe '#to_receipt_line' do
    it 'formats the receipt line correctly', :aggregate_failures do
      item = BucketItem.new(quantity: 2, product_name: 'book', price: BigDecimal('12.49'))
      expect(item.to_receipt_line).to eq('2 book: 24.98')

      item = BucketItem.new(quantity: 1, product_name: 'imported bottle of perfume', price: BigDecimal('47.50'))
      expect(item.to_receipt_line).to eq('1 imported bottle of perfume: 54.65')
    end
  end
end