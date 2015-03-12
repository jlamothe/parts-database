require_relative '../support/record.rb'

RSpec.describe Part, type: :model do
  subject { build :part }
  include_examples :record
end
