require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }
  let(:ability) { Ability.new(subject) }

  context 'user not signed in' do
    it 'should not be able to manage the user' do
      expect(ability.can? :manage, User).to eq false
    end
  end

  context 'user signed in' do
    context 'as non-admin' do
      before do
        subject.save!
      end

      it 'should not be able to manage users' do
        expect(ability.can? :manage, User).to eq false
      end
    end

    context 'as admin' do
      before do
        subject.admin = true
        subject.save!
      end

      it 'should be able to manage users' do
        expect(ability.can? :manage, User).to eq true
      end
    end
  end
end
