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

class Address < ActiveRecord::Base
  attr_accessible :city, :state, :streetaddress, :streetaddress2, :zip
end
