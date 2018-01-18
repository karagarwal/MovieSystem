class Showtime < ActiveRecord::Base
  validates :movie_id, :timing, presence: true
  has_many :tickets
  belongs_to :movie
end
