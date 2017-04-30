# == Schema Information
#
# Table name: bets
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  gee_id     :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :gee
  has_many :values

  validates :user, presence: true
  validates :gee, presence: true
  validates :quantity, presence: true
end
