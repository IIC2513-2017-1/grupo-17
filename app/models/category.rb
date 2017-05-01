# == Schema Information
#
# Table name: categories
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
