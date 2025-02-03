module PizzaFactory
  class Inventory
    def initialize
      @stock = Hash.new { |hash, key| hash[key] = Hash.new(0) }
    end

    def add_item(item, quantity)
      validate_quantity(quantity)
      type = item_type(item)
      @stock[type][item.name] += quantity
    end

    def use_item(item, quantity)
      validate_quantity(quantity)
      type = item_type(item)
      return false unless available?(item, quantity)

      @stock[type][item.name] -= quantity
      true
    end

    def available?(item, quantity)
      validate_quantity(quantity)
      type = item_type(item)
      @stock[type][item.name] >= quantity
    end

    def stock_level(item)
      type = item_type(item)
      @stock[type][item.name]
    end

    def deduct(item, quantity)
      if item.is_a?(Array)
        item.all? { |i| use_item(i, quantity) }
      else
        use_item(item, quantity)
      end
    end

    def valid?(item)
      if item.is_a?(Array)
        item.all? { |i| available?(i, 1) }
      else
        available?(item, 1)
      end
    end

    private

    def item_type(item)
      item.class.name.downcase.to_sym
    end

    def validate_quantity(quantity)
      raise ArgumentError, "Quantity must be greater than 0" if quantity <= 0
    end
  end
end
