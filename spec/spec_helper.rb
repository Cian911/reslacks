require 'bundler/setup'
require 'byebug'
require 'dotenv'
require 'factory_bot'
require 'faker'
require 'reslacks'

Dotenv.load

RSpec.configure do |config|
  # TODO: Either fix oOR remove FactoryBot...
  # FactoryBot for rspec
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
