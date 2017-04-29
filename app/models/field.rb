# == Schema Information
#
# Table name: fields
#
#  id         :integer          not null, primary key
#  gee_id     :integer
#  name       :string
#  ttype      :string
#  min_value  :integer
#  max_value  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Field < ApplicationRecord
  belongs_to :gee

  validates :gee, presence: true
  validates :name, presence: true, uniqueness: {
    scope: :gee, message: "Should be unique in a Gee"
  }
  validates :ttype, presence: true
end
