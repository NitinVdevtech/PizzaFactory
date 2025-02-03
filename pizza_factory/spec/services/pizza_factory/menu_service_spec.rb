require 'rspec'

RSpec.describe PizzaFactory::MenuService, type: :service do
  describe '.menu_data' do
    it 'returns the correct menu data structure' do
      menu_data = PizzaFactory::MenuService.menu_data

      expect(menu_data[:pizzas].keys).to contain_exactly(:vegetarian, :non_vegetarian)
      expect(menu_data[:crusts]).to include('New Hand Tossed', 'Wheat Thin Crust')
      expect(menu_data[:toppings][:all].size).to be > 0
      expect(menu_data[:sides].size).to be > 0
    end
  end

  describe '.display_menu' do
    it 'displays the menu correctly' do
      expect { PizzaFactory::MenuService.display_menu }.to output(/Non_vegetarian:/).to_stdout
    end
  end

  describe 'get_user_choice' do
    let(:options) { ['Option 1', 'Option 2', 'Option 3'] }
    let(:prompt) { 'Choose an option' }

    it 'returns a single choice when multiple is false' do
      allow($stdin).to receive(:gets).and_return("1")
    end

    it 'returns multiple choices when multiple is true' do
      allow($stdin).to receive(:gets).and_return('1,2')
    end
  end

  describe 'get_pizza_choice' do
    it 'returns the pizza choice correctly' do
      allow(PizzaFactory::MenuService).to receive(:get_user_choice).and_return(:vegetarian, { name: 'Deluxe Veggie' }, :regular)
      
      result = PizzaFactory::MenuService.get_pizza_choice
      
      expect(result).to eq({ pizza_type: :vegetarian, pizza: { name: 'Deluxe Veggie' }, size: :regular })
    end
  end

  describe 'get_crust_choice' do
    it 'returns the crust choice correctly' do
      allow(PizzaFactory::MenuService).to receive(:get_user_choice).and_return('New Hand Tossed')
      
      result = PizzaFactory::MenuService.get_crust_choice

      expect(result).to eq('New Hand Tossed')
    end
  end

  describe 'get_toppings_choice' do
    it 'returns the correct toppings choice when user confirms toppings' do
      allow(PizzaFactory::MenuService).to receive(:yes_or_no?).and_return(true)
      allow(PizzaFactory::MenuService).to receive(:get_user_choice).and_return([{ name: 'Black Olive', price: 20 }])

      result = PizzaFactory::MenuService.get_toppings_choice(:vegetarian)

      expect(result).to eq([{ name: 'Black Olive', price: 20 }])
    end

    it 'returns an empty array if user does not confirm toppings' do
      allow(PizzaFactory::MenuService).to receive(:yes_or_no?).and_return(false)

      result = PizzaFactory::MenuService.get_toppings_choice(:vegetarian)

      expect(result).to eq([])
    end
  end

  describe 'get_sides_choice' do
    it 'returns the correct sides choice when user confirms sides' do
      allow(PizzaFactory::MenuService).to receive(:yes_or_no?).and_return(true)
      allow(PizzaFactory::MenuService).to receive(:get_user_choice).and_return([{ name: 'Cold Drink', price: 55 }])

      result = PizzaFactory::MenuService.get_sides_choice

      expect(result).to eq([{ name: 'Cold Drink', price: 55 }])
    end

    it 'returns an empty array if user does not confirm sides' do
      allow(PizzaFactory::MenuService).to receive(:yes_or_no?).and_return(false)

      result = PizzaFactory::MenuService.get_sides_choice

      expect(result).to eq([])
    end
  end

  describe 'get_custom_order' do
    it 'returns the correct order' do
      allow(PizzaFactory::MenuService).to receive(:get_pizza_choice).and_return({ pizza_type: :vegetarian, pizza: { name: 'Deluxe Veggie' }, size: :regular })
      allow(PizzaFactory::MenuService).to receive(:get_crust_choice).and_return('New Hand Tossed')
      allow(PizzaFactory::MenuService).to receive(:get_toppings_choice).and_return([{ name: 'Black Olive', price: 20 }])
      allow(PizzaFactory::MenuService).to receive(:get_sides_choice).and_return([{ name: 'Cold Drink', price: 55 }])

      order = PizzaFactory::MenuService.get_custom_order

      expect(order).to include(
        pizza: { name: 'Deluxe Veggie' },
        size: :regular,
        crust: 'New Hand Tossed',
        toppings: [{ name: 'Black Olive', price: 20 }],
        sides: [{ name: 'Cold Drink', price: 55 }]
      )
    end
  end
end
