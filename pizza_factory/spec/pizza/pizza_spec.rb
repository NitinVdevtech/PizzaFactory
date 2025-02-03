require 'rspec'

RSpec.describe PizzaFactory::Pizza, type: :model do
  let(:crust) { instance_double("Crust", info: "Thin Crust") }
  let(:topping1) { instance_double("Topping", name: "Olives", price: 2, info: "Olives") }
  let(:topping2) { instance_double("Topping", name: "Mushrooms", price: 1.5, info: "Mushrooms") }
  let(:topping3) { instance_double("Topping", name: "Chicken", price: 3, non_vegetarian?: true, info: "Chicken") }
  let(:topping4) { instance_double("Topping", name: "Paneer", price: 2.5, paneer?: true, info: "Paneer") }

  let(:veg_pizza) { PizzaFactory::Pizza.new(name: "Veg Supreme", size: "Large", price: 12.99, is_veg: true) }
  let(:non_veg_pizza) { PizzaFactory::Pizza.new(name: "Chicken Delight", size: "Large", price: 15.99, is_veg: false) }

  describe "#initialize" do
    it "initializes with correct attributes" do
      expect(veg_pizza.name).to eq("Veg Supreme")
      expect(veg_pizza.size).to eq("Large")
      expect(veg_pizza.price).to eq(12.99)
      expect(veg_pizza.is_veg).to be(true)
      expect(veg_pizza.toppings).to eq([])
    end
  end
end
