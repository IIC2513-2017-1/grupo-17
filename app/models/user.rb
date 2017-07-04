# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  username            :string           not null
#  email               :string           not null
#  password_digest     :string           not null
#  is_admin            :boolean          default("false"), not null
#  money               :integer          default("0"), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  email_confirmed     :boolean          default("false")
#  confirm_token       :string
#  api_token           :string
#

class User < ApplicationRecord
  has_secure_password

  has_attached_file :avatar,
    :styles => { :medium => "300x300#", :thumb => "100x100#" },
    :default_url => "/images/:style/missing.png",
    :path => ":rails_root/tmp/attachments/:attachment/:id/:style/:filename"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :gees, dependent: :destroy
  has_many :bets, dependent: :destroy
  has_many :friendships, -> { where confirmed: true }
  has_many :friends, through: :friendships
  has_many :notifications

  validates :username,        presence: true, length: { in: 4..16 }, uniqueness: true
  validates :password_digest, presence: true
  validates :money,           presence: true, numericality: { greater_or_equal_than: 0 }
  validates :email,           presence: true, length: { in: 6..40 }, uniqueness: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    on: :create
  }

  before_save :set_defaults

  def set_defaults
    self.email_confirmed = false if self.email_confirmed.nil?
    self.is_admin = false if self.is_admin.nil?
    self.money = 0 if self.money.nil?
    self.api_token = SecureRandom.urlsafe_base64.to_s if self.api_token.nil?
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if self.confirm_token.nil?
  end

end
