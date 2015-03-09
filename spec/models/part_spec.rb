require 'rails_helper'

RSpec.describe Part, type: :model do
  subject { build :part }
  let(:user) { build :user }
  let(:ability) { Ability.new(user) }

  context "without user" do
    it "should be able to read" do
      expect(ability.can? :read, subject).to eq true
    end

    [:create, :update, :delete].each do |action|
      it "should not be able to #{action}" do
        expect(ability.can? action, subject).to eq false
      end
    end
  end

  context "with user" do
    context "as non-admin" do
      before do
        user.save!
      end

      it "should be able to read" do
        expect(ability.can? :read, subject).to eq true
      end

      [:create, :update, :delete].each do |action|
        it "should not be able to #{action}" do
          expect(ability.can? action, subject).to eq false
        end
      end
    end

    context "as admin" do
      before do
        user.admin = true
        user.save!
      end

      [:create, :read, :update, :delete].each do |action|
        it "should be able to #{action}" do
          expect(ability.can? action, subject).to eq true
        end
      end
    end
  end
end
