require_relative '../support/resource.rb'

RSpec.describe Part, type: :model do
  subject { build :part }
  it_should_behave_like 'a resource'
end
