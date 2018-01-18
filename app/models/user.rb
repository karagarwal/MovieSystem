class User < ActiveRecord::Base
  validates :phone, presence: true, length: { in: 10..15 }
  validates :name, :address, presence: true
  validates_inclusion_of :payment_mode, in: %w[Cash Card NetBanking], presence: true
  has_many :tickets
end