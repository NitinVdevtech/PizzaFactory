module PizzaFactory
  class Topping
    include Util
    attr_reader :name, :price, :is_veg

    def initialize(name:, price:, is_veg:)
      @name = name
      @price = price
      @is_veg = is_veg
    end

    def paneer?
      name.downcase.include?('paneer')
    end

    def info
      type = vegetarian? ? "vegetarian" : "non-vegetarian"
      "Topping : #{name} RS #{price} type"
    end
  end
end
