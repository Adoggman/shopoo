# == Schema Information
#
# Table name: billing_infos
#
#  id           :integer          not null, primary key
#  cardnumber   :string(255)
#  cardname     :string(255)
#  expiration   :date
#  securitycode :string(255)
#  address_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class BillingInfo < ActiveRecord::Base
  attr_accessible :cardname, :cardnumber, :expiration, :securitycode
  belongs_to :address
  has_one :user
  accepts_nested_attributes_for :address
end
