require 'rspec'

RSpec.describe PizzaFactory::OrderItem, type: :model do
  let(:pizza) { double('Pizza', total_price: 100) }
  let(:order_item) { described_class.new(pizza, 2) }

  describe '#initialize' do
    it 'initializes with a pizza and quantity' do
      expect(order_item.pizza).to eq(pizza)
      expect(order_item.quantity).to eq(2)
    end
  end

  describe '#total_price' do
    it 'calculates the total price based on pizza price and quantity' do
      expect(order_item.total_price).to eq(200)
    end

    it 'returns 0 when quantity is 0' do
      order_item_zero_quantity = described_class.new(pizza, 0)
      expect(order_item_zero_quantity.total_price).to eq(0)
    end
  end
end
