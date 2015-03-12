require_relative '../support/record.rb'

RSpec.describe Supplier, type: :model do
  subject { build :supplier }
  include_examples :record
end
