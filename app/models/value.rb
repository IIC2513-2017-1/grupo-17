# == Schema Information
#
# Table name: values
#
#  id       :integer          not null, primary key
#  bet_id   :integer          not null
#  field_id :integer          not null
#  value    :integer          not null
#

class Value < ApplicationRecord
  belongs_to :bet
  belongs_to :field

  validates :bet,   presence: true
  validates :field, presence: true
  validates :value, presence: true
end
