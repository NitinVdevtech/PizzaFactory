require 'rspec'

RSpec.describe PizzaFactory::Util, type: :module do
  class DummyClass
    include PizzaFactory::Util
    attr_reader :is_veg

    def initialize(is_veg)
      @is_veg = is_veg
    end
  end

  let(:veg_class) { DummyClass.new(true) }
  let(:non_veg_class) { DummyClass.new(false) }

  describe '#vegetarian?' do
    it 'returns true when the object is vegetarian' do
      expect(veg_class.vegetarian?).to be true
    end

    it 'returns false when the object is non-vegetarian' do
      expect(non_veg_class.vegetarian?).to be false
    end
  end

  describe '#non_vegetarian?' do
    it 'returns false when the object is vegetarian' do
      expect(veg_class.non_vegetarian?).to be false
    end

    it 'returns true when the object is non-vegetarian' do
      expect(non_veg_class.non_vegetarian?).to be true
    end
  end
end
