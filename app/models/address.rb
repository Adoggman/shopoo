class Address < ActiveRecord::Base
  attr_accessible :city, :state, :streetaddress, :streetaddress2, :zip
end
