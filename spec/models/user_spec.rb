require_relative '../support/record.rb'

RSpec.describe User, type: :model do
  subject { build :user }
  include_examples :record, false

  [:read, :update, :delete].each do |activity|
    it "should be able to #{activity} themselves" do
      subject.save!
      expect(Ability.new(subject).can? activity, subject).to be true
    end
  end
end
