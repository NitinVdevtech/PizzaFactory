module PizzaFactory
  class OrderService
    def initialize(inventory_service)
      @inventory_service = inventory_service
    end

    def place_order(order_data)
      pizza_details = order_data[:pizza]
      size = order_data[:size]
      crust = order_data[:crust]
      toppings = order_data[:toppings] || []
      sides = order_data[:sides] || []

      crust_obj = Crust.new(name: crust)

      topping_objects = toppings.map do |t|
        Topping.new(**t)
      end

      side_objects = sides.map do |s|
        Side.new(**s)
      end

      return nil unless @inventory_service.valid?(side_objects)

      pizza = PizzaService.create_pizza(pizza_details, size, crust_obj, topping_objects, side_objects, @inventory_service)

      return nil unless pizza

      side_objects.each { |s| @inventory_service.deduct(s) }

      order = Order.new
      order.add_item(pizza)
      side_objects.each { |side| order.add_item(side) }

      puts "Order placed successfully: #{pizza.name} (#{size}) with #{pizza.toppings.map(&:name).join(', ')}"

      order
    end
  end
end
