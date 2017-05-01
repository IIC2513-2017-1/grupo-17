# == Schema Information
#
# Table name: gees
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  category_id     :integer          not null
#  name            :string           not null
#  description     :string           default(""), not null
#  state           :string           default("opened"), not null
#  is_public       :boolean          default("true"), not null
#  expiration_date :datetime         not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Gee < ApplicationRecord
  belongs_to  :user
  belongs_to  :category
  has_many    :fields, dependent: :destroy

  validates :user,            presence: true
  validates :category,        presence: true
  validates :name,            presence: true, uniqueness: true
  validates :expiration_date, presence: true
  validates :state,           presence: true, inclusion: {
      in: %w(opened closed),
      message: "%{value} is not a valid state"
  }

  # The set_defaults will only work if the object is new
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.is_public = true if self.is_public.nil?
    self.state = "opened" if self.state.nil?
    self.description = "" if self.description.nil?
  end

end
