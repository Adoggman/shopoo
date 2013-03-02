class User < ActiveRecord::Base
  attr_accessible :address_id, :admin, :billing_info_id, :cart_id, :email, :firstname, :lastname, :password
  has_one :billing_info
  has_one :address
  has_one :cart
end
