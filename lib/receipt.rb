require 'debug'
require_relative '../lib/shopping_bucket_parser'
require_relative '../lib/receipt_item'

class Receipt
  attr_reader :bucket_items

  def initialize(input)
    @bucket_items = ShoppingBucketParser.parse(input).map do |bucket_item|
      ReceiptItem.new(
        quantity: bucket_item[:quantity],
        product_name: bucket_item[:product_name],
        price: bucket_item[:price]
      )
    end
  end

  def generate
    item_lines = @bucket_items.map(&:to_receipt_line)
    summary_lines = generate_summary

    (item_lines + summary_lines).join("\n")
  end

  private

  def generate_summary
    total_tax = @bucket_items.sum(&:total_tax)
    total_price = @bucket_items.sum(&:final_price).round(2, BigDecimal::ROUND_HALF_UP)

    [
      format('Sales Taxes: %.2f', round_to_nearest_5_cents(total_tax).to_s('F')),
      format('Total: %.2f', total_price.to_s('F'))
    ]
  end

  def round_to_nearest_5_cents(value)
    BigDecimal(((value * 20).ceil.to_f / 20.0).to_s)
  end
end