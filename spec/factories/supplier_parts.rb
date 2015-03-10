FactoryGirl.define do
  factory :supplier_part do
    part
    supplier
    sequence(:part_number) { |n| n.to_s }
  end
end
