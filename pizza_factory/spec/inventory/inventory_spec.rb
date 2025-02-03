require 'rspec'

RSpec.describe PizzaFactory::Inventory, type: :model do
  let(:pizza) { double('Pizza', name: 'Margherita') }
  let(:side) { double('Side', name: 'Garlic Bread') }
  let(:topping) { double('Topping', name: 'Cheese') }
  let(:inventory) { described_class.new }

  describe '#add_item' do
    it 'adds an item to the inventory' do
      inventory.add_item(pizza, 5)
      expect(inventory.stock_level(pizza)).to eq(5)
    end

    it 'raises an error if the quantity is less than or equal to zero' do
      expect { inventory.add_item(pizza, 0) }.to raise_error(ArgumentError, "Quantity must be greater than 0")
    end
  end

  describe '#use_item' do
    before { inventory.add_item(pizza, 5) }

    it 'decreases the stock level when using an item' do
      inventory.use_item(pizza, 2)
      expect(inventory.stock_level(pizza)).to eq(3)
    end

    it 'returns false if there is not enough stock to use' do
      expect(inventory.use_item(pizza, 6)).to eq(false)
    end

    it 'returns true if there is enough stock to use' do
      expect(inventory.use_item(pizza, 3)).to eq(true)
    end

    it 'raises an error if the quantity is less than or equal to zero' do
      expect { inventory.use_item(pizza, 0) }.to raise_error(ArgumentError, "Quantity must be greater than 0")
    end
  end

  describe '#available?' do
    before { inventory.add_item(pizza, 5) }

    it 'returns true if the item is available in the required quantity' do
      expect(inventory.available?(pizza, 3)).to eq(true)
    end

    it 'returns false if the item is not available in the required quantity' do
      expect(inventory.available?(pizza, 6)).to eq(false)
    end

    it 'raises an error if the quantity is less than or equal to zero' do
      expect { inventory.available?(pizza, 0) }.to raise_error(ArgumentError, "Quantity must be greater than 0")
    end
  end

  describe '#stock_level' do
    it 'returns the current stock level of an item' do
      inventory.add_item(pizza, 5)
      expect(inventory.stock_level(pizza)).to eq(5)
    end
  end

  describe '#deduct' do
    before { inventory.add_item(pizza, 5) }

    it 'deducts the stock of a single item' do
      inventory.deduct(pizza, 3)
      expect(inventory.stock_level(pizza)).to eq(2)
    end

    it 'deducts the stock of multiple items' do
      inventory.add_item(side, 10)
      inventory.deduct([pizza, side], 3)
      expect(inventory.stock_level(pizza)).to eq(2)
      expect(inventory.stock_level(side)).to eq(7)
    end

    it 'returns false if any item in the array is insufficient' do
      inventory.add_item(side, 1)
      result = inventory.deduct([pizza, side], 3)
      expect(result).to eq(false)
    end
  end

  describe '#valid?' do
    before { inventory.add_item(pizza, 5) }

    it 'returns true if an item is available in the required quantity' do
      expect(inventory.valid?(pizza)).to eq(true)
    end

    it 'returns false if an item is not available in the required quantity' do
      expect(inventory.valid?(side)).to eq(false)
    end

    it 'returns true if all items in an array are available' do
      inventory.add_item(side, 5)
      expect(inventory.valid?([pizza, side])).to eq(true)
    end

    it 'returns false if any item in an array is not available' do
      expect(inventory.valid?([pizza, side])).to eq(false)
    end
  end
end
