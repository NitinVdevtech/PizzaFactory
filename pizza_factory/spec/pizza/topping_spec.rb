require 'rspec'

RSpec.describe PizzaFactory::Topping, type: :model do
  let(:veg_topping) { PizzaFactory::Topping.new(name: "Mushroom", price: 50, is_veg: true) }
  let(:non_veg_topping) { PizzaFactory::Topping.new(name: "Chicken", price: 80, is_veg: false) }
  let(:paneer_topping) { PizzaFactory::Topping.new(name: "Paneer", price: 70, is_veg: true) }

  describe '#initialize' do
    it 'creates a topping with the given name, price, and is_veg attribute' do
      expect(veg_topping.name).to eq("Mushroom")
      expect(veg_topping.price).to eq(50)
      expect(veg_topping.is_veg).to eq(true)
    end
  end

  describe '#paneer?' do
    it 'returns true for a topping with "paneer" in the name' do
      expect(paneer_topping.paneer?).to be true
    end

    it 'returns false for a topping without "paneer" in the name' do
      expect(veg_topping.paneer?).to be false
    end
  end

  describe '#info' do
    it 'returns the correct information for a vegetarian topping' do
      expect(veg_topping.info).to eq("Topping : Mushroom RS 50 type")
    end

    it 'returns the correct information for a non-vegetarian topping' do
      expect(non_veg_topping.info).to eq("Topping : Chicken RS 80 type")
    end
  end
end
