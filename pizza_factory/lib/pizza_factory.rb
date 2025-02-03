require_relative "pizza_factory/version"

# Pizza Components
require_relative "pizza_factory/pizza/util"
require_relative "pizza_factory/pizza/pizza"
require_relative "pizza_factory/pizza/crust"
require_relative "pizza_factory/pizza/topping"
require_relative "pizza_factory/pizza/side"

# Inventory & Order
require_relative "pizza_factory/inventory/inventory"
require_relative "pizza_factory/order/order"
require_relative "pizza_factory/order/order_item"

# Errors, Handler & Logger
require_relative "pizza_factory/errors/error_handler"
require_relative "pizza_factory/errors/error_logger"
require_relative "pizza_factory/errors/errors"

# Service Layer
require_relative "pizza_factory/services/pizza_service"
require_relative "pizza_factory/services/inventory_service"
require_relative "pizza_factory/services/order_service"
require_relative "pizza_factory/services/menu_service"

module PizzaFactory
end
