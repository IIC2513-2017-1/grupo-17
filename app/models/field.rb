# == Schema Information
#
# Table name: fields
#
#  id            :integer          not null, primary key
#  gee_id        :integer          not null
#  name          :string           not null
#  ttype         :string           not null
#  min_value     :integer
#  max_value     :integer
#  correct_value :integer
#

class Field < ApplicationRecord
  belongs_to :gee
  has_many   :alternatives, dependent: :destroy

  validates :gee,   presence: true
  validates :name,  presence: true, uniqueness: {
    scope: :gee, message: "Should be unique in a Gee"
  }
  validates :ttype, presence: true, inclusion: {
    in: %w(Number Alternatives),
    message: "%{value} is not a valid type"
  }
end
