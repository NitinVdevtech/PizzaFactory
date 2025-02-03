require "bundler/setup"
require "pizza_factory"

inventory_service = PizzaFactory::InventoryService.new
order_service = PizzaFactory::OrderService.new(inventory_service)

def get_order
  PizzaFactory::MenuService.display_menu
  PizzaFactory::MenuService.get_custom_order
end

def place_order(order_service, order_data)
  order = order_service.place_order(order_data)
  if order
    order.confirm! if order.pending?
    puts order.info
  else
    puts "Order not confirmed"
  end
end

def refill_all_stock(inventory_service)
  data = PizzaFactory::MenuService.menu_data
  crusts = data[:crusts].map { |c| PizzaFactory::Crust.new(name: c) }
  toppings = (data[:toppings][:all] + data[:toppings][:vegetarian] + data[:toppings][:non_vegetarian]).map { |t| PizzaFactory::Topping.new(**t) }
  sides = data[:sides].map { |s| PizzaFactory::Side.new(**s) }

  (crusts + toppings + sides).each { |item| inventory_service.restock(item, 5) }
end

refill_all_stock(inventory_service)
order_data = get_order
place_order(order_service, order_data)
