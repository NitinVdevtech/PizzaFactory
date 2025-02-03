module PizzaFactory
  class Pizza
    include Util

    attr_reader :name, :size, :price, :is_veg, :crust, :toppings

    def initialize(name:, size:, price:, is_veg:)
      @name = name
      @size = size
      @price = price
      @is_veg = is_veg
      @toppings = []
    end

    def set_crust(crust)
      raise InvalidCrustError, "Crust must be a valid object" unless crust.is_a?(Crust)

      @crust = crust
    end

    def add_topping(topping)
      raise InvalidToppingError, "Topping must be a valid object" unless topping.is_a?(Topping)

      @toppings << topping
      validate_toppings!
    end

    def total_price
      base_price = @price
      toppings_for_cost_cal = toppings.sort_by(&:price)
      toppings_for_cost_cal = toppings_for_cost_cal[2..-1] || [] if large?

      extra_toppings_cost = toppings_for_cost_cal.sum(&:price)
      base_price + extra_toppings_cost
    end

    def info
      [crust.info] + toppings.map(&:info)
    end

    def large? 
      size == :large
    end

    def valid?
      validate_crust!
      validate_toppings!
      true
    end

    private

    def validate_crust!
      raise InvalidCrustError, "Crust is required" if crust.nil?
    end

    def validate_toppings!
      raise InvalidToppingError, "Vegetarian pizza cannot have non-veg toppings" if vegetarian_with_non_veg_toppings?
      raise InvalidToppingError, "Non-veg pizza can have only one non-veg topping" if non_vegetarian_with_multiple_non_veg_toppings?
      raise InvalidToppingError, "Non-veg pizza cannot have paneer" if non_vegetarian_with_paneer?
    end

    def vegetarian_with_non_veg_toppings?
      vegetarian? && @toppings.any?(&:non_vegetarian?)
    end

    def non_vegetarian_with_multiple_non_veg_toppings?
      non_vegetarian? && @toppings.count(&:non_vegetarian?) > 1
    end

    def non_vegetarian_with_paneer?
      non_vegetarian? && @toppings.any?(&:paneer?)
    end
  end
end
