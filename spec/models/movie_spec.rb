require 'rails_helper'
RSpec.describe Movie, type: :model do
  context 'validations' do
    it 'is a valid movie' do
      FactoryGirl.build(:movie).should be_valid
    end

    it 'is invalid without name' do
      FactoryGirl.build(:movie, name: nil).should_not be_valid
    end

    it 'is invalid without a rating' do
      FactoryGirl.build(:movie, rating: nil).should_not be_valid
    end

    it 'is invalid without a duration' do
      FactoryGirl.build(:movie, duration: nil).should_not be_valid
    end

    it 'is invalid without a language' do
      FactoryGirl.build(:movie, language: nil).should_not be_valid
    end

    it 'validates movie rating in 5' do
      FactoryGirl.build(:movie, rating: 6).should_not be_valid
    end

    it 'validates movie language' do
      FactoryGirl.build(:movie, language: 'Chinese').should_not be_valid
    end

    it 'validates movie theater_id' do
      FactoryGirl.build(:movie, theater_id: nil).should_not be_valid
    end
  end

  context 'assosiation test' do
    it 'should belongs to theater' do
      theater = FactoryGirl.create(:theater)
      movie = FactoryGirl.create(:movie, theater_id: theater.id)
      movie.theater.id.should eq theater.id
    end

    it 'should belongs to audi' do
      audi = FactoryGirl.create(:audi)
      movie = FactoryGirl.create(:movie, audi_id: audi.id)
      movie.audi.id.should eq audi.id
    end

    it 'should not belong to invalid theater' do
      theater1 = FactoryGirl.create(:theater)
      theater2 = FactoryGirl.create(:theater)
      movie = FactoryGirl.create(:movie, theater_id: theater1.id)
      movie.theater.id.should eq theater1.id
      movie.theater.id.should_not eq theater2.id
    end

    it 'should not belong to invalid audi' do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      movie = FactoryGirl.create(:movie, audi_id: audi1.id)
      movie.audi.id.should eq audi1.id
      movie.audi.id.should_not eq audi2.id
    end

    it 'should has many showtimes' do
      movie = FactoryGirl.create(:movie)
      showtime1 = FactoryGirl.create(:showtime, movie_id: movie.id)
      showtime2 = FactoryGirl.create(:showtime, movie_id: movie.id)
      movie.showtimes.should include showtime1
      movie.showtimes.should include showtime2
    end

    it 'should has many tickets' do
      movie = FactoryGirl.create(:movie)
      ticket = FactoryGirl.create(:ticket, movie_id: movie.id)
      movie.tickets.should include ticket
    end

    it 'should not has unincluded showtimes' do
      movie1 = FactoryGirl.create(:movie)
      movie2 = FactoryGirl.create(:movie)
      showtime1 = FactoryGirl.create(:showtime, movie_id: movie1.id)
      showtime2 = FactoryGirl.create(:showtime, movie_id: movie2.id)
      movie1.showtimes.should include showtime1
      movie1.showtimes.should_not include showtime2
      movie2.showtimes.should include showtime2
      movie2.showtimes.should_not include showtime1
    end

    it 'should not has unincluded tickets' do
      movie1 = FactoryGirl.create(:movie)
      movie2 = FactoryGirl.create(:movie)
      ticket1 = FactoryGirl.create(:ticket, movie_id: movie1.id)
      ticket2 = FactoryGirl.create(:ticket, movie_id: movie2.id)
      movie1.tickets.should include ticket1
      movie1.tickets.should_not include ticket2
      movie2.tickets.should include ticket2
      movie2.tickets.should_not include ticket1
    end
  end
end
