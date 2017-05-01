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

require 'test_helper'

class GeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
