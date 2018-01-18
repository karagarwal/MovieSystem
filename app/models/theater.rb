class Theater < ActiveRecord::Base
  validates :phone, presence: true, length: { in: 10..15 }
  validates :theater_name, :address, presence: true
  has_many :audis
  has_many :movies
end
