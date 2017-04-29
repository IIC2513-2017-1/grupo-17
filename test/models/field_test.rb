# == Schema Information
#
# Table name: fields
#
#  id         :integer          not null, primary key
#  gee_id     :integer
#  name       :string
#  ttype      :string
#  min_value  :integer
#  max_value  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FieldTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
