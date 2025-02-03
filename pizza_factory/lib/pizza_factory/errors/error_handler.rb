module PizzaFactory
  class ErrorHandler
    def self.handle(error)
      ErrorLogger.log_error(error)
    end
  end
end