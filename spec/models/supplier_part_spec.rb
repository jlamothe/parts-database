require_relative '../support/resource.rb'

RSpec.describe SupplierPart, type: :model do
  subject { build :supplier_part }
  it_should_behave_like 'a resource'
end
