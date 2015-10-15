RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Method
  config.before(:suite) { FactoryGirl.reload }
end