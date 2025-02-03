require 'rspec'

RSpec.describe PizzaFactory::Crust, type: :model do
  describe '#initialize' do
    it 'initializes with a name' do
      crust = PizzaFactory::Crust.new(name: 'Thin Crust')
      expect(crust.name).to eq('Thin Crust')
    end
  end

  describe '#info' do
    it 'returns the correct information string' do
      crust = PizzaFactory::Crust.new(name: 'Thick Crust')
      expect(crust.info).to eq('Crust : Thick Crust')
    end
  end
end
