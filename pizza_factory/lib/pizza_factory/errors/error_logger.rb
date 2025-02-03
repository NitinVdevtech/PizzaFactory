module PizzaFactory
  class ErrorLogger
    def self.log_error(error)
      puts "[ERROR] #{Time.now}: #{error.message}"
    end
  end
end
