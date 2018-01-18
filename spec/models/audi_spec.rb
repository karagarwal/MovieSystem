require 'rails_helper'
RSpec.describe Audi, type: :model do
  context 'validations' do
    it 'is a valid audi' do
      FactoryGirl.build(:audi).should be_valid
    end

    it 'is invalid without code' do
      FactoryGirl.build(:audi, code: nil).should_not be_valid
    end

    it 'is invalid without a Number_of_seats' do
      FactoryGirl.build(:audi, number_of_seats: nil).should_not be_valid
    end

    it 'is invalid without a theater_id' do
      p FactoryGirl.build(:audi, theater_id: nil).should_not be_valid
    end

    it 'validates audi code' do
      FactoryGirl.build(:audi, code: 15).should_not be_valid
    end

    it 'validates audi seats yo be numeric' do
      FactoryGirl.build(:audi, number_of_seats: 'qq').should_not be_valid
    end
  end

  context 'assosiation test' do
    it 'should belongs to theater' do
      theater = FactoryGirl.create(:theater)
      audi = FactoryGirl.create(:audi, theater_id: theater.id)
      audi.theater.id.should eq theater.id
    end

    it 'should not belong to invalid theater' do
      theater1 = FactoryGirl.create(:theater)
      theater2 = FactoryGirl.create(:theater)
      audi = FactoryGirl.create(:audi, theater_id: theater1.id)
      audi.theater.id.should eq theater1.id
      audi.theater.id.should_not eq theater2.id
    end

    it 'should has many seat_types' do
      audi = FactoryGirl.create(:audi)
      seat_type = FactoryGirl.create(:seat_type, audi_id: audi.id)
      audi.seat_types.should include seat_type
    end

    it 'should has many tickets' do
      audi = FactoryGirl.create(:audi)
      ticket = FactoryGirl.create(:ticket, audi_id: audi.id)
      audi.tickets.should include ticket
    end

    it 'should has many movies' do
      audi = FactoryGirl.create(:audi)
      movie = FactoryGirl.create(:movie, audi_id: audi.id)
      audi.movies.should include movie
    end

    it 'should not has unincluded seat_types' do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      seat_type1 = FactoryGirl.create(:seat_type, audi_id: audi1.id)
      seat_type2 = FactoryGirl.create(:seat_type, audi_id: audi2.id)
      audi1.seat_types.should include seat_type1
      audi1.seat_types.should_not include seat_type2
      audi2.seat_types.should include seat_type2
      audi2.seat_types.should_not include seat_type1
    end

    it 'should not has unincluded tickets' do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      ticket1 = FactoryGirl.create(:ticket, audi_id: audi1.id)
      ticket2 = FactoryGirl.create(:ticket, audi_id: audi2.id)
      audi1.tickets.should include ticket1
      audi1.tickets.should_not include ticket2
      audi2.tickets.should include ticket2
      audi2.tickets.should_not include ticket1
    end

    it 'should not has unincluded movies' do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      movie1 = FactoryGirl.create(:movie, audi_id: audi1.id)
      movie2 = FactoryGirl.create(:movie, audi_id: audi2.id)
      audi1.movies.should include movie1
      audi1.movies.should_not include movie2
      audi2.movies.should include movie2
      audi2.movies.should_not include movie1
    end
  end
end
