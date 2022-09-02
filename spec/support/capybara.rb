require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
  end
end

# Capybara.configure do |config|
#   config.run_server = false
# end
