module PizzaFactory
  class OrderItem
    attr_reader :pizza, :quantity

    def initialize(pizza, quantity)
      @pizza = pizza
      @quantity = quantity
    end

    def total_price
      @pizza.total_price * @quantity
    end
  end
end
