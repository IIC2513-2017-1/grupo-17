class Gee < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true,
  validates :expiration_date, presence: true
end
