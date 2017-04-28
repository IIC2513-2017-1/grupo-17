class Field < ApplicationRecord
  belongs_to :gee

  validates :gee, presence: true
  validates :name, presence: true, uniqueness: {
    scope: :gee, message: "Should be unique in a Gee"
  }
  validates :ttype, presence: true
end
