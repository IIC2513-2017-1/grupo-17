# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string           not null
#  description :string
#  url         :string
#  read        :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :user
end
