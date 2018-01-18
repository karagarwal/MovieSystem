require 'rails_helper'
RSpec.describe Showtime, type: :model do
  context 'validations' do
    it 'is a valid movie' do
      theater = FactoryGirl.build(:theater)
      FactoryGirl.build(:showtime).should be_valid
    end

    it 'is invalid without a timing' do
      FactoryGirl.build(:showtime, timing: nil).should_not be_valid
    end

    it 'is invalid without a movie_id' do
      FactoryGirl.build(:showtime, movie_id: nil).should_not be_valid
    end
  end

  context 'assosiation test' do
    it 'should belongs to movie' do
      movie = FactoryGirl.create(:movie)
      showtime = FactoryGirl.create(:showtime, movie_id: movie.id)
      showtime.movie.id.should eq movie.id
    end

    it 'should not belong to invalid movie' do
      movie1 = FactoryGirl.create(:movie)
      movie2 = FactoryGirl.create(:movie)
      showtime = FactoryGirl.create(:showtime, movie_id: movie1.id)
      showtime.movie.id.should eq movie1.id
      showtime.movie.id.should_not eq movie2.id
    end

    it 'should has many tickets' do
      showtime = FactoryGirl.create(:showtime)
      ticket = FactoryGirl.create(:ticket, showtime_id: showtime.id)
      showtime.tickets.should include ticket
    end

    it 'should not has unincluded tickets' do
      showtime1 = FactoryGirl.create(:showtime)
      showtime2 = FactoryGirl.create(:showtime)
      ticket1 = FactoryGirl.create(:ticket, showtime_id: showtime1.id)
      ticket2 = FactoryGirl.create(:ticket, showtime_id: showtime2.id)
      showtime1.tickets.should include ticket1
      showtime1.tickets.should_not include ticket2
      showtime2.tickets.should include ticket2
      showtime2.tickets.should_not include ticket1
    end
  end
end
