require 'rails_helper'

RSpec.describe SupplierPart, type: :model do
  subject { build :supplier_part }
  let(:user) { build :user }
  let(:ability) { Ability.new(user) }

  context 'user not signed in' do
    it 'should not be able to create a supplier part' do
      expect(ability.can? :create, SupplierPart).to eq false
    end

    [:read, :update, :delete].each do |action|
      it "should not be able to #{ action } a supplier part" do
        expect(ability.can? action, subject).to eq false
      end
    end
  end

  context 'user signed in' do
    context 'as a non-admin' do
      before do
        user.save!
      end

      it 'should not be able to create a supplier part' do
        expect(ability.can? :create, SupplierPart).to eq false
      end

      [:read, :update, :delete].each do |action|
        it "should not be able to #{ action } a supplier part" do
          expect(ability.can? action, subject).to eq false
        end
      end
    end

    context 'as an admin' do
      before do
        user.admin = true
        user.save!
      end

      it 'should be able to create a supplier part' do
        expect(ability.can? :create, SupplierPart).to eq true
      end

      [:read, :update, :delete].each do |action|
        it "should be able to #{ action } a supplier part" do
          expect(ability.can? action, subject).to eq true
        end
      end
    end
  end
end
