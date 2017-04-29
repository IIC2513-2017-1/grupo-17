# == Schema Information
#
# Table name: values
#
#  id         :integer          not null, primary key
#  bet_id     :integer
#  field_id   :integer
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ValueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
