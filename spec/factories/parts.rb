FactoryGirl.define do
  factory :part do
    sequence(:name) { |n| "Part #{n}" }
    sequence(:description) { |n| "Description for part #{n}" }
  end
end
