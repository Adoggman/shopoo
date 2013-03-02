# == Schema Information
#
# Table name: cart_promos
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  promo_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CartPromoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
