module PizzaFactory
  class MenuService
    PROMPTS = {
      pizza_type: "Choose Pizza Type: (1) Vegetarian, (2) Non-Vegetarian",
      crust_type: "Choose Crust Type",
      size: "Choose Size: (1) Regular, (2) Medium, (3) Large",
      toppings: "Choose Toppings (Select multiple by entering numbers separated by commas)",
      sides: "Choose Sides (Select multiple by entering numbers separated by commas)",
      order_confirmation: "Would you like toppings? ",
      sides_confirmation: "Would you like sides? "
    }

    def self.menu_data
      {
        pizzas: {
          vegetarian: [
            { name: 'Deluxe Veggie', prices: { regular: 150, medium: 200, large: 325 }, is_veg: true },
            { name: 'Cheese and Corn', prices: { regular: 175, medium: 375, large: 475 }, is_veg: true},
            { name: 'Paneer Tikka', prices: { regular: 160, medium: 290, large: 340 }, is_veg: true}
          ],
          non_vegetarian: [
            { name: 'Non-Veg Supreme', prices: { regular: 190, medium: 325, large: 425 }, is_veg: false},
            { name: 'Chicken Tikka', prices: { regular: 210, medium: 370, large: 500 }, is_veg: false},
            { name: 'Pepper Barbecue Chicken', prices: { regular: 220, medium: 380, large: 525 }, is_veg: false}
          ]
        },
        crusts: [
          'New Hand Tossed',
          'Wheat Thin Crust',
          'Cheese Burst',
          'Fresh Pan Pizza'
        ],
        toppings: {
          all: [
            { name: 'Black Olive', price: 20, is_veg: true},
            { name: 'Capsicum', price: 25, is_veg: true},
            { name: 'Mushroom', price: 30, is_veg: true},
            { name: 'Fresh Tomato', price: 10, is_veg: true}
          ],
          vegetarian: [
            { name: 'Paneer', price: 35, is_veg: false}
          ],
          non_vegetarian: [
            { name: 'Chicken Tikka', price: 35, is_veg: false},
            { name: 'Barbeque Chicken', price: 45, is_veg: false},
            { name: 'Grilled Chicken', price: 40, is_veg: false}
          ]
        },
        sides: [
          { name: 'Cold Drink', price: 55 },
          { name: 'Mousse Cake', price: 90 }
        ]
      }
    end

    def self.display_menu
      puts "\n Pizza Menu:"
      menu_data[:pizzas].each do |type, pizzas|
        puts "\n#{type.to_s.capitalize}:"
        pizzas.each do |pizza|
          puts "  - #{pizza[:name]} (Regular: ₹#{pizza[:prices][:regular]}, Medium: ₹#{pizza[:prices][:medium]}, Large: ₹#{pizza[:prices][:large]})"
        end
      end

      puts "\n Available Crusts:"
      menu_data[:crusts].each { |c| puts "  - #{c}" }

      display_topping_menu(:vegetarian)
      display_topping_menu(:non_vegetarian)

      puts "\n Sides: #{menu_data[:sides].map { |s| "#{s[:name]} (₹#{s[:price]})" }.join(', ')}"
    end

    def self.display_topping_menu(type)
      toppings = menu_data[:toppings][type] + menu_data[:toppings][:all]
      puts "\n #{type.to_s.capitalize} Toppings: #{toppings.map { |t| "#{t[:name]} (₹#{t[:price]})" }.join(', ')}"
    end

    def self.get_user_choice(options, prompt, multiple: false)
      puts "\n#{prompt}"
      options.each_with_index { |option, index| puts "#{index + 1}. #{option.is_a?(Hash) ? option[:name] : option}" }

      choice_input = gets.chomp
      if multiple
        # Handling multiple choices (comma-separated input)
        choices = choice_input.split(',').map { |c| c.to_i - 1 }.uniq
        choices = choices.select { |choice| choice.between?(0, options.length - 1) }
        return choices.map { |choice| options[choice] }
      else
        # Handling single choice (normal input)
        choice = choice_input.to_i - 1
        return options[choice] if choice.between?(0, options.length - 1)
      end
    end

    def self.get_pizza_choice
      type = get_user_choice(menu_data[:pizzas].keys, PROMPTS[:pizza_type]).to_sym
      pizza = get_user_choice(menu_data[:pizzas][type], "Choose Your Pizza")
      size = get_user_choice(%i[regular medium large], PROMPTS[:size])

      {pizza_type: type, pizza: pizza, size: size }
    end

    def self.get_crust_choice
      get_user_choice(menu_data[:crusts], PROMPTS[:crust_type])
    end

    def self.get_toppings_choice(type)
      return [] unless yes_or_no?(PROMPTS[:order_confirmation])
      topping_options = menu_data[:toppings][:all] + menu_data[:toppings][type]
      toppings = get_user_choice(topping_options, PROMPTS[:toppings], multiple: true)
      toppings.is_a?(Array) ? toppings : [toppings]
    end

    def self.get_sides_choice
      return [] unless yes_or_no?(PROMPTS[:sides_confirmation])

      sides = get_user_choice(menu_data[:sides], PROMPTS[:sides], multiple: true)
      sides.is_a?(Array) ? sides : [sides]
    end

    def self.yes_or_no?(question)
      puts "\n#{question} (y/n)"
      gets.chomp.downcase == 'y'
    end

    def self.get_custom_order
      choices = get_pizza_choice
      order = {}
      order[:pizza] = choices[:pizza]
      order[:size] = choices[:size]
      order[:crust] = get_crust_choice
      order[:toppings] = get_toppings_choice(choices[:pizza_type])
      order[:sides] = get_sides_choice
      display_final_order(order)
      order
    end

    def self.display_final_order(order)
      puts "\n Your Final Order:"
      puts "   Pizza: #{order[:pizza][:name]} (#{order[:size].capitalize})"
      puts "   Crust: #{order[:crust]}"
      puts "   Toppings: #{order[:toppings].map { |t| t[:name] }.join(', ')}" unless order[:toppings].empty?
      puts "   Sides: #{order[:sides].map { |s| s[:name] }.join(', ')}" unless order[:sides].empty?
      order
    end
  end
end
