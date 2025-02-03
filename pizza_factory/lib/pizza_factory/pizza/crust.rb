module PizzaFactory
  class Crust
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def info
      "Crust : #{name}"
    end
  end
end
