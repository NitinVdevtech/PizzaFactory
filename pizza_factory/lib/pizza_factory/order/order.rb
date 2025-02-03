module PizzaFactory
  class Order
    @@order_count = 0

    attr_reader :id, :items, :status

    def initialize
      @@order_count += 1
      @id = format("ORDER_ID_%05d", @@order_count)  # Auto-increment order ID
      @items = []
      pending!
    end

    def add_item(item)
      @items << item
    end

    def confirm!
      @status = :confirm
    end

    def confirm?
      @status == :confirm
    end

    def pending!
      @status = :pending
    end

    def pending?
      @status == :pending
    end

    def total_price
      @items.sum(&:total_price)
    end

    def info
      @items.map(&:info)+["total_price: #{total_price}"]
    end
  end
end
