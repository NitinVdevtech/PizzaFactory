module PizzaFactory
  # Base error for all PizzaFactory-related exceptions
  class PizzaFactoryError < StandardError
    def initialize(message = "An error occurred in PizzaFactory")
      super(message)
    end
  end

  class InvalidCrustError < PizzaFactoryError
    def initialize(crust, message = "Invalid crust type")
      super("#{message}: #{crust}")
    end
  end

  class InvalidToppingError < PizzaFactoryError
    def initialize(toppings, message = "Invalid topping(s)")
      if toppings.is_a?(Array) && toppings.all? { |topping| topping.respond_to?(:name) }
        super("#{message}: #{toppings.map(&:name).join(', ')}")
      else
        super(message)
      end
    end
  end

  class InvalidPizzaError < PizzaFactoryError
    def initialize(pizza, message = "Invalid pizza type")
      super("#{message}: #{pizza}")
    end
  end

  class OutOfStockError < PizzaFactoryError
    def initialize(item, message = "Item out of stock")
      super("#{message}: #{item}")
    end
  end

  class InvalidOrderError < PizzaFactoryError
    def initialize(order_id, message = "Invalid order operation")
      super("#{message}: Order ID #{order_id}")
    end
  end
end
