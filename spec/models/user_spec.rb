require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }
  let(:user) { build :user }
  let(:ability) { Ability.new(user) }

  context 'not signed in' do
    it "should not be able to create a user" do
      expect(ability.can? :create, User).to eq false
    end

    [:read, :update, :delete].each do |action|
      it "should not be able to #{action} a user" do
        expect(ability.can? ability, subject).to eq false
      end
    end
  end

  context 'signed in' do
    context 'as non-admin' do
      before do
        user.save!
      end

      it "should not be able to create a user" do
        expect(ability.can? :create, User).to eq false
      end

      [:read, :update, :delete].each do |action|
        it "should not be able to #{action} a user" do
          expect(ability.can? action, subject).to eq false
        end
      end

      [:read, :update].each do |action|
        it "should be able to #{action} themselves" do
          expect(ability.can? action, user).to eq true
        end
      end
    end

    context 'as admin' do
      before do
        user.admin = true
        user.save!
      end

      it "should be able to create a user" do
        expect(ability.can? :create, User).to eq true
      end

      [:read, :update, :delete].each do |action|
        it "should be able to #{action} a user" do
          expect(ability.can? action, subject).to eq true
        end
      end
    end
  end
end
