require 'rails_helper'

RSpec.shared_examples :record do |readable = true|
  let(:user) { create :user }
  let(:ability) { Ability.new(user) }

  context 'a user not signed in' do
    it "should not be able to create a #{described_class.name.humanize.downcase}" do
      expect(ability.can? :create, described_class).to be false
    end

    it "should #{readable ? '' : 'not '}be able to read a #{described_class.name.humanize.downcase}" do
      expect(ability.can? :read, subject).to be readable
    end

    [:update, :delete].each do |activity|
      it "should not be able to #{activity} a #{described_class.name.humanize.downcase}" do
        expect(ability.can? activity, subject).to be false
      end
    end
  end

  context 'a user signed in' do
    context 'as a non-admin' do
      before do
        user.save!
      end

      it "should not be able to create a #{described_class.name.humanize.downcase}" do
        expect(ability.can? :create, described_class).to be false
      end

      it "should #{readable ? '' : 'not '}be able to read a #{described_class.name.humanize.downcase}" do
        expect(ability.can? :read, subject).to be readable
      end

      [:update, :delete].each do |activity|
        it "should not be able to #{activity} a #{described_class.name.humanize.downcase}" do
          expect(ability.can? activity, subject).to be false
        end
      end
    end

    context 'as an admin' do
      before do
        user.admin = true
        user.save!
      end

      it "should be able to create a #{described_class.name.humanize.downcase}" do
        expect(ability.can? :create, described_class).to be true
      end

      [:read, :update, :delete].each do |activity|
        it "should be able to #{activity} a #{described_class.name.humanize.downcase}" do
          expect(ability.can? activity, subject).to be true
        end
      end
    end
  end
end
