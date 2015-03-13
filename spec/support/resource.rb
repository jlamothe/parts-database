require 'rails_helper'

RSpec.shared_examples 'a resource' do |readable = true|
  let(:user) { create :user }
  let(:ability) { Ability.new(user) }

  context 'a user not signed in' do
    [:new, :create].each do |action|
      it "should not be able to perform the #{ action } action" do
        expect(ability.can? action, described_class).to be false
      end
    end

    it "should #{ readable ? '' : 'not ' }be able to perform the index action" do
      expect(ability.can? :index, described_class).to eq readable
    end

    it "should #{ readable ? '' : 'not ' }be able to perform the show action" do
      expect(ability.can? :show, subject).to eq readable
    end

    [:edit, :update, :delete].each do |action|
      it "should not be able to perform the #{ action } action" do
        expect(ability.can? action, subject).to be false
      end
    end
  end

  context 'a user signed in' do
    context 'as a non-admin' do
      before do
        user.save!
      end

      [:new, :create].each do |action|
        it "should not be able to perform the #{ action } action" do
          expect(ability.can? action, described_class).to be false
        end
      end

      it "should #{ readable ? '' : 'not ' }be able to perform the index action" do
        expect(ability.can? :index, described_class).to eq readable
      end

      it "should #{ readable ? '' : 'not ' }be able to perform the show action" do
        expect(ability.can? :show, subject).to eq readable
      end

      [:edit, :update, :delete].each do |action|
        it "should not be able to perform the #{ action } action" do
          expect(ability.can? action, subject).to be false
        end
      end
    end

    context 'as an admin' do
      before do
        user.admin = true
        user.save!
      end

      [:new, :create, :index].each do |action|
        it "should be able to perform the #{ action } action" do
          expect(ability.can? action, described_class).to be true
        end
      end

      [:show, :edit, :update, :delete].each do |action|
        it "should be able to perform the #{ action } action" do
          expect(ability.can? action, subject).to be true
        end
      end
    end
  end
end
