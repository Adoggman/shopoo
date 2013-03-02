class BillingInfo < ActiveRecord::Base
  attr_accessible :cardname, :cardnumber, :expiration, :securitycode

  has_one :address
end
