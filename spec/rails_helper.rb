require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |file| require file }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before :suite do
    begin
      print "Checking for invalid factories..."
      DatabaseCleaner.start
      FactoryBot.lint verbose: true
      puts " done."
    ensure
      DatabaseCleaner.clean
    end
  end

  config.after :each do
    Faker::UniqueGenerator.clear
  end
end

RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length = 100000

ActiveRecord::Migration.maintain_test_schema!

require "shoulda/matchers"
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

require "shoulda/matchers"
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

require 'webmock/rspec'
WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: [
      /lvh\.me/,
      "fonts.googleapis.com",
      "cdnjs.cloudflare.com",
      "youtube.com",
      Webdrivers::Chromedriver.base_url,
  ],
)

require 'capybara/rspec'

Capybara.server = :puma, { Silent: true }

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.load_selenium

  browser_options = ::Selenium::WebDriver::Chrome::Options.new
  browser_options.add_argument '--headless'
  browser_options.add_argument '--no-sandbox'
  browser_options.add_argument '--disable-dev-shm-usage'
  browser_options.add_argument '--window-size=1920,1080'

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.default_driver = ENV.fetch("CAPYBARA_DEFAULT_DRIVER", "rack_test").to_sym
Capybara.javascript_driver = ENV.fetch("CAPYBARA_JS_DRIVER", "headless_chrome").to_sym

Capybara.ignore_hidden_elements = true
Capybara.default_max_wait_time = ENV.fetch("CAPYBARA_DEFAULT_MAX_WAIT_TIME", "2").to_i

Capybara.app_host = Routes.root_url(port: nil).chomp("/")
Capybara.server_port = Routes.default_port
Capybara.always_include_port = true

def ss
  page.save_and_open_screenshot
end
