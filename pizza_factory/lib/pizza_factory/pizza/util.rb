module PizzaFactory
  module Util
    def vegetarian?
      @is_veg
    end

    def non_vegetarian?
      !vegetarian?
    end
  end
end
  