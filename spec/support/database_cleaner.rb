require 'rake'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end

    # Remove all dynamic tables
    DatabaseCleaner.connections.each do |connection|
      collections = connection.strategy.send(:database).collections rescue []
      collections.select { |c| c.name.starts_with?('tables.') }.each(&:drop)
    end
  end
end
