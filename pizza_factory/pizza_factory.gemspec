# frozen_string_literal: true

require_relative "lib/pizza_factory/version"

Gem::Specification.new do |spec|
  spec.name = "pizza_factory"
  spec.version = PizzaFactory::VERSION
  spec.authors = ["Nitin"]
  spec.email = ["nitinvermadevtech07@gmail.com"]

  spec.summary = "PizzaFactory is a Ruby gem that provides a simple yet extensible **Pizza Ordering System**. It manages inventory, validates orders, and allows customization of pizzas."
  spec.description = "PizzaFactory is a Ruby gem designed to manage a pizza ordering service for a startup. It powers self-service terminals where customers can customize and place orders. The backend service handles menu management, inventory tracking, and order validation. It ensures that ingredients are available before confirming orders and forwards them to backend systems."
  spec.homepage = "https://github.com/nitinvermadevtech07/pizza_factory"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nitinvermadevtech07/pizza_factory"
  spec.metadata["changelog_uri"] = "https://github.com/nitinvermadevtech07/pizza_factory/releases"
  spec.metadata["bug_tracker_uri"] = "https://github.com/nitinvermadevtech07/pizza_factory/issues"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
