module HelperMethods
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include HelperMethods
end