require 'rails_helper'
RSpec.describe User, type: :model do
  context 'validations' do
    it 'is a valid user' do
      FactoryGirl.build(:user).should be_valid
    end

    it 'is invalid without name' do
      FactoryGirl.build(:user, name: nil).should_not be_valid
    end

    it 'is invalid without a address' do
      FactoryGirl.build(:user, address: nil).should_not be_valid
    end

    it 'is invalid without a phone' do
      FactoryGirl.build(:user, phone: nil).should_not be_valid
    end

    it 'is invalid without a payment_mode' do
      FactoryGirl.build(:user, payment_mode: nil).should_not be_valid
    end

    it 'validates user payment_mode' do
      FactoryGirl.build(:user, payment_mode: 'Free').should_not be_valid
    end

    it 'validates phone length' do
      FactoryGirl.build(:user, phone: 123_456).should_not be_valid
    end
  end

  context 'assosiation test' do
    it 'should has many tickets' do
      user = FactoryGirl.create(:user)
      ticket = FactoryGirl.create(:ticket, user_id: user.id)
      user.tickets.should include ticket
    end

    it 'should not has unincluded tickets' do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      ticket1 = FactoryGirl.create(:ticket, user_id: user1.id)
      ticket2 = FactoryGirl.create(:ticket, user_id: user2.id)
      user1.tickets.should include ticket1
      user1.tickets.should_not include ticket2
      user2.tickets.should include ticket2
      user2.tickets.should_not include ticket1
    end
  end
end
