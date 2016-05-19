RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
    Mongoid.purge!
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Mongoid.purge!
  end

end
