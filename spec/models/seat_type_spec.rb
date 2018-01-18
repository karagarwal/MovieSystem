require 'rails_helper'
RSpec.describe SeatType, type: :model do
  context 'validations' do
    it 'is a valid seat' do
      FactoryGirl.build(:seat_type).should be_valid
    end

    it 'is invalid without category' do
      FactoryGirl.build(:seat_type, category: nil).should_not be_valid
    end

    it 'validates seat category' do
      FactoryGirl.build(:seat_type, category: 'Simple').should_not be_valid
    end
  end

  context 'assosiation test' do
    it 'should belongs to audi' do
      audi = FactoryGirl.create(:audi)
      seat_type = FactoryGirl.create(:seat_type, audi_id: audi.id)
      seat_type.audi.id.should eq audi.id
    end

    it 'should not belong to invalid audi' do
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      seat_type = FactoryGirl.create(:seat_type, audi_id: audi1.id)
      seat_type.audi_id.should eq audi1.id
      seat_type.audi.id.should_not eq audi2.id
    end
  end
end
