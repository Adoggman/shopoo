# == Schema Information
#
# Table name: promos
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  item_id    :integer
#  discount   :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PromoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
