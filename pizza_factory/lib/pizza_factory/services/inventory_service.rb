module PizzaFactory
  class InventoryService
    def initialize
      @inventory = Inventory.new
    end

    def restock(item, quantity)
      @inventory.add_item(item, quantity)
    end

    def check_availability?(item, quantity)
      @inventory.available?(item, quantity)
    end

    def deduct(item)
      raise "#{item.class} not available: #{item.name}" unless @inventory.valid?(item)

      @inventory.deduct(item, 1)
    end

    def valid?(item)
      @inventory.valid?(item)
    end
  end
end
