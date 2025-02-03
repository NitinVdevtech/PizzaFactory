module PizzaFactory
  class PizzaService
    def self.create_pizza(pizza_details, size, crust, toppings, sides, inventory_service)

      return nil unless inventory_service.valid?(crust)
      return nil unless inventory_service.valid?(toppings)

      pizza = Pizza.new(
        name: pizza_details[:name],
        size: size,
        price: pizza_details[:prices][size],
        is_veg: pizza_details[:is_veg] || false
      )

      pizza.set_crust(crust)

      toppings.each do |topping|
        pizza.add_topping(topping)
      end

      return nil unless pizza.valid?

      inventory_service.deduct(crust)
      inventory_service.deduct(toppings)

      pizza
    end
  end
end
