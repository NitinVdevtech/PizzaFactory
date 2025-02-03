require 'rspec'

RSpec.describe PizzaFactory::PizzaService, type: :service do
  let(:inventory_service) { double('InventoryService', valid?: true, deduct: nil) }
  let(:crust) { instance_double('PizzaFactory::Crust') }
  let(:topping) { instance_double('Topping', name: 'Cheese', non_vegetarian?: false) }
  let(:pizza_details) do
    {
      name: 'Margherita',
      prices: { small: 5.99, medium: 7.99, large: 9.99 },
      is_veg: true
    }
  end

  let(:size) { :medium }
  let(:toppings) { [topping] }
  let(:sides) { [] }

  describe '.create_pizza' do
    context 'when the inventory is valid' do
      it 'creates a pizza with the correct details' do
        allow(crust).to receive(:is_a?).with(PizzaFactory::Crust).and_return(true)
        allow(topping).to receive(:is_a?).with(PizzaFactory::Topping).and_return(true)
        allow(topping).to receive(:non_vegetarian?).and_return(false)

        pizza = described_class.create_pizza(pizza_details, size, crust, toppings, sides, inventory_service)

        expect(pizza).not_to be_nil
        expect(pizza.name).to eq('Margherita')
        expect(pizza.size).to eq(size)
        expect(pizza.price).to eq(pizza_details[:prices][size])
        expect(pizza.is_veg).to be true
      end

      it 'sets the crust for the pizza' do
        allow(crust).to receive(:is_a?).with(PizzaFactory::Crust).and_return(true)
        allow(topping).to receive(:is_a?).with(PizzaFactory::Topping).and_return(true)

        pizza = described_class.create_pizza(pizza_details, size, crust, toppings, sides, inventory_service)

        expect(pizza.crust).to eq(crust)
      end

      it 'adds toppings to the pizza' do
        allow(crust).to receive(:is_a?).with(PizzaFactory::Crust).and_return(true)
        allow(topping).to receive(:is_a?).with(PizzaFactory::Topping).and_return(true)

        pizza = described_class.create_pizza(pizza_details, size, crust, toppings, sides, inventory_service)

        expect(pizza.toppings).to include(topping)
      end

      it 'deducts crust and toppings from inventory' do
        allow(crust).to receive(:is_a?).with(PizzaFactory::Crust).and_return(true)
        allow(topping).to receive(:is_a?).with(PizzaFactory::Topping).and_return(true)

        expect(inventory_service).to receive(:deduct).with(crust)
        expect(inventory_service).to receive(:deduct).with(toppings)

        described_class.create_pizza(pizza_details, size, crust, toppings, sides, inventory_service)
      end
    end

    context 'when the pizza is not valid' do
      it 'returns nil if the pizza is invalid' do
        allow(crust).to receive(:is_a?).with(PizzaFactory::Crust).and_return(true)
        allow(topping).to receive(:is_a?).with(PizzaFactory::Topping).and_return(true)

        allow_any_instance_of(PizzaFactory::Pizza).to receive(:valid?).and_return(false)

        pizza = described_class.create_pizza(pizza_details, size, crust, toppings, sides, inventory_service)

        expect(pizza).to be_nil
      end
    end
  end
end
