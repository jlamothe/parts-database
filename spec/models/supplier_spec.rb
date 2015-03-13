require_relative '../support/resource.rb'

RSpec.describe Supplier, type: :model do
  subject { build :supplier }
  it_should_behave_like 'a resource'
end
