# == Schema Information
#
# Table name: values
#
#  id         :integer          not null, primary key
#  bet_id     :integer
#  field_id   :integer
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Value < ApplicationRecord
  belongs_to :bet
  belongs_to :field

  validates :bet, presence: true
  validates :field, presence: true
  validates :value, presence: true
end
