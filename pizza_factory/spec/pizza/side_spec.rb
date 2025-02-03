require 'rspec'

RSpec.describe PizzaFactory::Side, type: :model do
  let(:side) { PizzaFactory::Side.new(name: "Garlic Bread", price: 100) }

  describe '#initialize' do
    it 'creates a side with the given name and price' do
      expect(side.name).to eq("Garlic Bread")
      expect(side.price).to eq(100)
    end
  end

  describe '#total_price' do
    it 'is the same as the price' do
      expect(side.total_price).to eq(100)
    end
  end

  describe '#info' do
    it 'returns the correct information string' do
      expect(side.info).to eq("Side : Garlic Bread RS 100")
    end
  end
end
