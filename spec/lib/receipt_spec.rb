require_relative '../../lib/receipt'
require_relative '../../lib/shopping_bucket_parser'
require_relative '../../lib/bucket_item'
require_relative '../../lib/tax_calculator'
require 'rspec'
require 'bigdecimal'

RSpec.describe Receipt do
  describe '#initialize' do
    it 'initializes instances of ReceiptItems (@bucket_items)' do
      input = <<~INPUT
        2 book at 12.49
        1 music CD at 14.99
      INPUT

      receipt = Receipt.new(input)
      expect(receipt.bucket_items.size).to eq(2)
      expect(receipt.bucket_items[0].product_name).to eq('book')
      expect(receipt.bucket_items[1].product_name).to eq('music CD')
    end
  end

  describe '#generate' do
    it 'generates the correct receipt output for input 1' do
      input = <<~INPUT
        2 book at 12.49
        1 music CD at 14.99
        1 chocolate bar at 0.85
      INPUT

      expected_output = <<~OUTPUT
        2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
      OUTPUT

      receipt = Receipt.new(input)
      expect(receipt.generate).to eq(expected_output.strip)
    end

    it 'generates the correct receipt output for input 2' do
      input = <<~INPUT
        1 imported box of chocolates at 10.00
        1 imported bottle of perfume at 47.50
      INPUT

      expected_output = <<~OUTPUT
        1 imported box of chocolates: 10.50
        1 imported bottle of perfume: 54.65
        Sales Taxes: 7.65
        Total: 65.15
      OUTPUT

      receipt = Receipt.new(input)
      expect(receipt.generate).to eq(expected_output.strip)
    end

    it 'generates the correct receipt output for input 3' do
      input = <<~INPUT
        1 imported bottle of perfume at 27.99
        1 bottle of perfume at 18.99
        1 packet of headache pills at 9.75
        3 imported boxes of chocolates at 11.25
      INPUT

      expected_output = <<~OUTPUT
        1 imported bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 packet of headache pills: 9.75
        3 imported boxes of chocolates: 35.55
        Sales Taxes: 7.90
        Total: 98.38
      OUTPUT

      receipt = Receipt.new(input)
      expect(receipt.generate).to eq(expected_output.strip)
    end
  end
end