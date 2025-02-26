require_relative '../../lib/tax_calculator'
require 'rspec'
require 'debug'

RSpec.describe TaxCalculator do
  subject(:calculate) { described_class.calculate(product_name, price, quantity) }

  describe '.calculate' do
    let(:price) { BigDecimal('100') }
    let(:quantity) { 1 }

    context 'when exempt products' do
      context 'when books' do
        let(:product_name) { 'book' }

        it 'calculates zero tax' do
          expect(calculate).to eq(BigDecimal('0.00'))
        end
      end

      context 'when chocolate' do
        let(:product_name) { 'chocolate bar' }

        it 'calculates zero tax' do
          expect(calculate).to eq(BigDecimal('0.00'))
        end
      end

      context 'when pills' do
        let(:product_name) { 'packet of headache pills' }

        it 'calculates zero tax' do
          expect(calculate).to eq(BigDecimal('0.00'))
        end
      end
    end

    context 'when imported products' do
      context 'when imported perfume' do
        let(:product_name) { 'imported bottle of perfume' }

        it 'calculates correct tax' do
          expect(calculate).to eq(BigDecimal('15.00'))
        end
      end

      context 'when imported chocolates' do
        let(:product_name) { 'imported boxes of chocolates' }

        it 'calculates correct tax' do
          expect(calculate).to eq(BigDecimal('5.00'))
        end
      end
    end

    context 'when regular products' do
      context 'when music CD' do
        let(:product_name) { 'music CD' }

        it 'calculates correct tax' do
          expect(calculate).to eq(BigDecimal('10.00'))
        end
      end

      context 'when bottle of perfume' do
        let(:product_name) { 'bottle of perfume' }

        it 'calculates correct tax' do
          expect(calculate).to eq(BigDecimal('10.00'))
        end
      end
    end

    context 'when rounding to nearest 5 cents' do
      context 'when rounding up' do
        let(:product_name) { 'imported something' }
        let(:price) { BigDecimal('1.01') }

        it 'rounds up correctly' do
          expect(calculate).to eq(BigDecimal('0.20'))
        end
      end

      context 'when rounding down' do
        let(:product_name) { 'imported something' }
        let(:price) { BigDecimal('1.02') }

        it 'rounds down correctly' do
          expect(calculate).to eq(BigDecimal('0.20'))
        end
      end
    end
  end
end