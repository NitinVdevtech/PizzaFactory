require 'rspec'

RSpec.describe PizzaFactory::Order, type: :model do
  let(:pizza) { double('Pizza', total_price: 100, info: 'Pizza Info') }
  let(:order_item) { PizzaFactory::OrderItem.new(pizza, 2) }
  let(:order) { described_class.new }

  describe '#initialize' do
    it 'initializes with a unique order ID' do
      expect(order.id).to match(/^ORDER_ID_\d{5}$/)
    end

    it 'initializes with an empty items array' do
      expect(order.items).to be_empty
    end

    it 'sets the status to pending' do
      expect(order.status).to eq(:pending)
    end
  end

  describe '#add_item' do
    it 'adds an item to the order' do
      order.add_item(order_item)
      expect(order.items).to include(order_item)
    end
  end

  describe '#confirm!' do
    it 'sets the status to confirm' do
      order.confirm!
      expect(order.status).to eq(:confirm)
    end
  end

  describe '#confirm?' do
    it 'returns true if the status is confirm' do
      order.confirm!
      expect(order.confirm?).to be true
    end

    it 'returns false if the status is pending' do
      expect(order.confirm?).to be false
    end
  end

  describe '#pending!' do
    it 'sets the status to pending' do
      order.pending!
      expect(order.status).to eq(:pending)
    end
  end

  describe '#pending?' do
    it 'returns true if the status is pending' do
      expect(order.pending?).to be true
    end

    it 'returns false if the status is confirm' do
      order.confirm!
      expect(order.pending?).to be false
    end
  end

  describe '#total_price' do
    it 'calculates the total price of all items in the order' do
      order.add_item(order_item)
      expect(order.total_price).to eq(200)
    end
  end
end
