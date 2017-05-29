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
  has_many    :bets, dependent: :destroy

  #validates :fields,                          length: { minimum: 1 }
  validates :user,            presence: true
  validates :category,        presence: true
  validates :name,            presence: true, uniqueness: true
  validates :expiration_date, presence: true
  validates :state,           presence: true, inclusion: {
      in: %w(opened closed),
  }

  # The set_defaults will only work if the object is new
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.is_public = true if self.is_public.nil?
    self.state = "opened" if self.state.nil?
    self.description = "" if self.description.nil?
  end

  def bets_amount
    bets.length
  end

  def money_well
    bets.map { |bet| bet.quantity }.sum
  end

  def owner_name
    user.username
  end

  def winner_option
    '-'
  end

  def self.to_csv(options = {})
    data = {
        'Name':          'name',
        'Owner':         'owner_name',
        'Created at':    'created_at',
        'Expires at':    'expiration_date',
        'Bets':          'bets_amount',
        'Money well':    'money_well',
        'Winner option': 'winner_option'
    }
    CSV.generate(options) do |csv|
      csv << data.keys
      all.each do |gee|
        csv << data.values.map { |attr| gee.send(attr) }
      end
    end
  end

end
