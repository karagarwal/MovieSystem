class Ticket < ActiveRecord::Base
  validates :seat_number, numericality: { only_integer: true }, presence: true
  validates :price, numericality: { only_decimal: true }, presence: true
  belongs_to :movie
  belongs_to :audi
  belongs_to :showtime
  belongs_to :seat_type
  belongs_to :user
 end