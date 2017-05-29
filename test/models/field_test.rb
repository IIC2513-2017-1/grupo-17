# == Schema Information
#
# Table name: fields
#
#  id            :integer          not null, primary key
#  gee_id        :integer          not null
#  name          :string           not null
#  ttype         :string           not null
#  min_value     :integer
#  max_value     :integer
#  correct_value :integer
#

require 'test_helper'

class FieldTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
