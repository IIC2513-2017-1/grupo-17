class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :gee

  validates :user, presence: true
  validates :gee, presence: true
  validates :quantity, presence: true
end
