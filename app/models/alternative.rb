class Alternative < ApplicationRecord
  belongs_to :field

  validates :field, presence: true
  validates :value, presence: true, uniqueness: {
    scope: :field, message: "Should be unique inside a field"
  }
end
