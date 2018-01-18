require 'rails_helper'
RSpec.describe Ticket, type: :model do
  context 'validations' do
    it 'is a valid ticket' do
      FactoryGirl.build(:ticket).should be_valid
    end

    it 'is invalid without a seat_number' do
      FactoryGirl.build(:ticket, seat_number: nil).should_not be_valid
    end

    it 'is invalid without a price' do
      FactoryGirl.build(:ticket, price: nil).should_not be_valid
    end

    it 'valid ticket price to be numeric value' do
      FactoryGirl.build(:ticket, price: 'ee').should_not be_valid
    end
  end

  context 'assosiation test' do
    it 'should belongs to user' do
      user = FactoryGirl.create(:user)
      ticket = FactoryGirl.create(:ticket, user_id: user.id)
      ticket.user.id.should eq user.id
    end

    it 'should belongs to showtime' do
      showtime = FactoryGirl.create(:showtime)
      ticket = FactoryGirl.create(:ticket, showtime_id: showtime.id)
      ticket.showtime.id.should eq showtime.id
    end

    it 'should belongs to audi' do
      audi = FactoryGirl.create(:audi)
      ticket = FactoryGirl.create(:ticket, audi_id: audi.id)
      ticket.audi.id.should eq audi.id
    end

    it 'should belongs to movie' do
      movie = FactoryGirl.create(:movie)
      ticket = FactoryGirl.create(:ticket, movie_id: movie.id)
      ticket.movie.id.should eq movie.id
    end

    it 'should belongs to seat_type' do
      seat_type = FactoryGirl.create(:seat_type)
      ticket = FactoryGirl.create(:ticket, seat_type_id: seat_type.id)
      ticket.seat_type.id.should eq seat_type.id
    end

    it 'should not belong to invalid user' do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)
      ticket = FactoryGirl.create(:ticket, user_id: user1.id)
      ticket.user.id.should eq user1.id
      ticket.user.id.should_not eq user2.id
    end

    it 'should not belong to invalid showtime' do
      showtime1 = FactoryGirl.create(:showtime)
      showtime2 = FactoryGirl.create(:showtime)
      ticket = FactoryGirl.create(:ticket, showtime_id: showtime1.id)
      ticket.showtime.id.should eq showtime1.id
      ticket.showtime.id.should_not eq showtime2.id
    end

    it 'should not belong to invalid audi' do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      ticket = FactoryGirl.create(:ticket, audi_id: audi1.id)
      ticket.audi.id.should eq audi1.id
      ticket.audi.id.should_not eq audi2.id
    end

    it 'should not belong to invalid movie' do
      movie1 = FactoryGirl.create(:movie)
      movie2 = FactoryGirl.create(:movie)
      ticket = FactoryGirl.create(:ticket, movie_id: movie1.id)
      ticket.movie.id.should eq movie1.id
      ticket.movie.id.should_not eq movie2.id
    end

    it 'should not belong to invalid seat_type' do
      seat_type1 = FactoryGirl.create(:seat_type)
      seat_type2 = FactoryGirl.create(:seat_type)
      ticket = FactoryGirl.create(:ticket, seat_type_id: seat_type1.id)
      ticket.seat_type.id.should eq seat_type1.id
      ticket.seat_type.id.should_not eq seat_type2.id
    end
  end
end
