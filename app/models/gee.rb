# == Schema Information
#
# Table name: gees
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  name            :string
#  description     :string
#  category_id     :integer
#  expiration_date :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Gee < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :fields

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true
  validates :expiration_date, presence: true
end
