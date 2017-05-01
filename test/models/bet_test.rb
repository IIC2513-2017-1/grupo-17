# == Schema Information
#
# Table name: bets
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  gee_id     :integer          not null
#  quantity   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class BetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
