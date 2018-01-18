class SeatType < ActiveRecord::Base
  belongs_to :audi
  has_many :tickets
  validates_inclusion_of :category, in: %w[Silver Gold Platinum], presence: true
end
