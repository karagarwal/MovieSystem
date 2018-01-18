class Movie < ActiveRecord::Base
  validates :name, :duration, :theater_id, presence: true
  validates_inclusion_of :rating, in: [1, 2, 3, 4, 5], presence: true
  validates_inclusion_of :language, in: %w[Hindi English Telgu], presence: true
  has_many :tickets
  has_many :showtimes
  belongs_to :theater
  belongs_to :audi
end
