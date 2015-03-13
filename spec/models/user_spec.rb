require_relative '../support/resource.rb'

RSpec.describe User, type: :model do
  subject { build :user }
  it_should_behave_like 'a resource', false

  [:show, :edit, :update, :delete].each do |activity|
    it "should be able to #{activity} themselves" do
      subject.save!
      expect(Ability.new(subject).can? activity, subject).to be true
    end
  end
end
