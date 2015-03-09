require 'rails_helper'

RSpec.describe Part, type: :model do
  subject { build :part }
  let(:user) { build :user }
  let(:ability) { Ability.new(user) }

  context "not signed in" do
    it "should not be able to create a user" do
      expect(ability.can? :create, Part).to eq false
    end

    it "should be able to read" do
      expect(ability.can? :read, subject).to eq true
    end

    [:update, :delete].each do |action|
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

      it "should not be able to create a user" do
        expect(ability.can? :create, Part).to eq false
      end

      it "should be able to read" do
        expect(ability.can? :read, subject).to eq true
      end

      [:update, :delete].each do |action|
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

      it "should be able to create a part" do
        expect(ability.can? :create, Part).to eq true
      end

      [:read, :update, :delete].each do |action|
        it "should be able to #{action}" do
          expect(ability.can? action, subject).to eq true
        end
      end
    end
  end
end
