require 'rails_helper'

RSpec.describe SupplierPart, type: :model do
  subject { build :supplier_part }
  include_examples :record
end
