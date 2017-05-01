# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string           not null
#  email      :string           not null
#  password   :string           not null
#  is_admin   :boolean          default("false"), not null
#  money      :integer          default("0"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :gees, dependent: :destroy
  has_many :bets, dependent: :destroy

  validates :username, presence: true, length: { in: 4..16 }, uniqueness: true
  validates :password, presence: true, length: { in: 6..40 }
  validates :money,    presence: true, numericality: {
      greater_or_equal_than: 0
  }
  validates :email,    presence: true, length: { in: 6..40 }, uniqueness: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    on: :create
  }

  # The set_defaults will only work if the object is new
  after_initialize :set_defaults

  def set_defaults
    self.is_admin = false if self.is_admin.nil?
    self.money = 0 if self.money.nil?
  end

end
