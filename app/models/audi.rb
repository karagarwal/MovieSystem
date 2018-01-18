class Audi < ActiveRecord::Base
  validates :number_of_seats, presence: true, numericality: { less_than_or_equal_to: 100 }
  validates :code, presence: true, numericality: { less_than_or_equal_to: 10 }
  validates :theater_id, presence: true
  has_many :movies
  has_many :seat_types
  has_many :tickets
  belongs_to :theater
end
