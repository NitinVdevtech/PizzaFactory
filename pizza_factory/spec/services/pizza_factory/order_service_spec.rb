require 'rspec'

RSpec.describe PizzaFactory::OrderService, type: :service do
  let(:inventory_service) { instance_double('InventoryService') }
  let(:pizza_details) { { name: 'Deluxe Veggie' } }
  let(:order_data) do
    {
      pizza: pizza_details,
      size: 'Medium',
      crust: 'Hand Tossed',
      toppings: [{ name: 'Olives', price: 2, is_veg: true }],
      sides: [{ name: 'Garlic Bread', price: 5 }]
    }
  end

  let(:crust_obj) { instance_double('Crust', name: 'Hand Tossed') }
  let(:topping_obj) { instance_double('Topping', name: 'Olives', price: 2, is_veg: true) }
  let(:side_obj) { instance_double('Side', name: 'Garlic Bread', price: 5) }
  let(:pizza) { instance_double('Pizza', name: 'Deluxe Veggie', toppings: [topping_obj]) }
  let(:order) { instance_double('Order') }

  subject { described_class.new(inventory_service) }

  before do
    stub_const("Order", Class.new { def add_item(_item); end })
    allow(PizzaFactory::Order).to receive(:new).and_return(order)
    allow(order).to receive(:add_item)
    allow(inventory_service).to receive(:valid?).and_return(true)
    allow(inventory_service).to receive(:deduct)
    allow(PizzaFactory::PizzaService).to receive(:create_pizza).and_return(pizza)
  end

  describe '#place_order' do
    context 'when the inventory is invalid' do
      before { allow(inventory_service).to receive(:valid?).and_return(false) }

      it 'returns nil' do
        result = subject.place_order(order_data)
        expect(result).to be_nil
      end
    end

    context 'when the pizza creation fails' do
      before { allow(PizzaFactory::PizzaService).to receive(:create_pizza).and_return(nil) }

      it 'returns nil' do
        result = subject.place_order(order_data)
        expect(result).to be_nil
      end
    end

    context 'when the order is valid' do
      it 'creates the pizza and adds it to the order' do
        result = subject.place_order(order_data)
        expect(result).to eq(order)
        expect(PizzaFactory::PizzaService).to have_received(:create_pizza)
        expect(order).to have_received(:add_item).with(pizza)
      end
  
      it 'adds sides to the order' do
        result = subject.place_order(order_data)
        expect(order).to have_received(:add_item).with(an_instance_of(PizzaFactory::Side))
      end
  
      it 'deducts sides from the inventory' do
        subject.place_order(order_data)
        expect(inventory_service).to have_received(:deduct).with(an_instance_of(PizzaFactory::Side))
      end
  
      it 'prints a success message' do
        allow($stdout).to receive(:puts)
        subject.place_order(order_data)
        expect($stdout).to have_received(:puts).with("Order placed successfully: Deluxe Veggie (Medium) with Olives")
      end
    end
  end
end
