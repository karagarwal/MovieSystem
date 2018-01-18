require 'rails_helper'
RSpec.describe Theater, type: :model do
  context 'validations' do
    it 'is a valid theater' do
      FactoryGirl.build(:theater).should be_valid
    end

    it 'is invalid without theater_name' do
      FactoryGirl.build(:theater, theater_name: nil).should_not be_valid
    end

    it 'is invalid without a address' do
      FactoryGirl.build(:theater, address: nil).should_not be_valid
    end

    it 'is invalid without a phone' do
      FactoryGirl.build(:theater, phone: nil).should_not be_valid
    end

    it 'validates phone length' do
      FactoryGirl.build(:theater, phone: 123_456).should_not be_valid
    end
  end

  context 'assosiation test' do
    it 'should has many audis' do
      theater = FactoryGirl.create(:theater)
      audi = FactoryGirl.create(:audi, theater_id: theater.id)
      theater.audis.should include audi
    end

    it 'should has many movies' do
      theater = FactoryGirl.create(:theater)
      movie = FactoryGirl.create(:movie, theater_id: theater.id)
      theater.movies.should include movie
    end

    it 'should not has unincluded audis' do
      theater1 = FactoryGirl.create(:theater)
      theater2 = FactoryGirl.create(:theater)
      audi1 = FactoryGirl.create(:audi, theater_id: theater1.id)
      audi2 = FactoryGirl.create(:audi, theater_id: theater2.id)
      theater1.audis.should include audi1
      theater1.audis.should_not include audi2
      theater2.audis.should include audi2
      theater2.audis.should_not include audi1
    end

    it 'should not has unincluded movies' do
      theater1 = FactoryGirl.create(:theater)
      theater2 = FactoryGirl.create(:theater)
      movie1 = FactoryGirl.create(:movie, theater_id: theater1.id)
      movie2 = FactoryGirl.create(:movie, theater_id: theater2.id)
      theater1.movies.should include movie1
      theater1.movies.should_not include movie2
      theater2.movies.should include movie2
      theater2.movies.should_not include movie1
    end
  end
end
