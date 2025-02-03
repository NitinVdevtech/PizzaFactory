module PizzaFactory
  class Side
    attr_reader :name, :price
    alias total_price price

    def initialize(name:, price:)
      @name = name
      @price = price
    end

    def info
      "Side : #{name} RS #{price}"
    end
  end
end
