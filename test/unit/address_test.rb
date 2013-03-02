# == Schema Information
#
# Table name: addresses
#
#  id             :integer          not null, primary key
#  streetaddress  :string(255)
#  streetaddress2 :string(255)
#  city           :string(255)
#  state          :string(255)
#  zip            :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
