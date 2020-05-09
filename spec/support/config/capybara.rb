require 'capybara/rspec'
require 'capybara-screenshot/rspec'

JS_DRIVER = :selenium_chrome_headless

Capybara.default_driver = :rack_test
Capybara.javascript_driver = JS_DRIVER
Capybara.default_max_wait_time = 2

Capybara::Screenshot.register_driver(:selenium_chrome_headless) do |driver, path|
  driver.browser.save_screenshot(path)
end

RSpec.configure do |config|
  # config.before(:each) do |example|
  #   Capybara.current_driver = JS_DRIVER if example.metadata[:js]
  #   Capybara.current_driver = :selenium if example.metadata[:selenium]
  #   Capybara.current_driver = :selenium_chrome if example.metadata[:selenium_chrome]
  # end

  config.before(:each, type: :feature, js: true) do
    Capybara.current_driver = :selenium_chrome_headless
  end

  config.before(:each, type: :feature, browser: true) do
    Capybara.current_driver = :selenium_chrome
  end


  config.after(:each, type: :feature) do
    Capybara.use_default_driver
  end
end
