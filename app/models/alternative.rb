# == Schema Information
#
# Table name: alternatives
#
#  id       :integer          not null, primary key
#  field_id :integer          not null
#  value    :string           not null
#

class Alternative < ApplicationRecord
  belongs_to :field

  validates :field, presence: true
  validates :value, presence: true, uniqueness: {
    scope: :field, message: "Should be unique inside a field"
  }
end
