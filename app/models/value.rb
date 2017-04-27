class Value < ApplicationRecord
  belongs_to :bet
  belongs_to :field

  validates :bet, presence: true
  validates :field, presence: true
  validates :value, presence: true
end
