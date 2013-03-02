# == Schema Information
#
# Table name: quantities
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  item_id    :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class QuantityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
