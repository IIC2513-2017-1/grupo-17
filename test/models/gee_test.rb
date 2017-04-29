# == Schema Information
#
# Table name: gees
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  name            :string
#  description     :string
#  category_id     :integer
#  expiration_date :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class GeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
