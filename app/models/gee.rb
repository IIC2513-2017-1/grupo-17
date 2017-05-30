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
  has_and_belongs_to_many :users

  #validates :fields,                          length: { minimum: 1 }
  validates :user,            presence: true
  validates :category,        presence: true
  validates :name,            presence: true, uniqueness: true
  validates :expiration_date, presence: true
  validates :state,           presence: true, inclusion: {
      in: %w(opened closed),
  }

  scope :visible, -> (current_user) {
    if current_user
      joins('LEFT JOIN gees_users ON gees.id=gees_users.gee_id')
      .where(state: 'opened')
        .where('is_public=true OR gees_users.user_id=:current_user_id',
          current_user_id: current_user.id)
    else
      where(is_public: true, state: 'opened')
    end
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

  def correct_answer
    correct_results = []
    fields.each do |field|
      value = field.correct_value
      if value.nil?
        return '(Gee still open)'
      end
      if field.ttype == 'Alternatives'
        value = field.alternatives.find(value).value
      end
      correct_results << "#{field.name}=#{value}"
    end
    correct_results.join('|')
  end

  def winner_bets
    winners = []
    bets.includes(values: [:field]).each do |bet|
      winner = true
      bet.values.each do |value|
        if value.value != value.field.correct_value
          winner = false
          break
        end
      end
      if winner
        winners << bet
      end
    end
    winners
  end

  def self.to_csv(options = {})
    data = {
        'Name':           'name',
        'Owner':          'owner_name',
        'Created at':     'created_at',
        'Expires at':     'expiration_date',
        'Bets':           'bets_amount',
        'Money well':     'money_well',
        'Correct answer': 'correct_answer'
    }
    CSV.generate(options) do |csv|
      csv << data.keys
      all.each do |gee|
        csv << data.values.map { |attr| gee.send(attr) }
      end
    end
  end

end
