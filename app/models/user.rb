# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  firstname       :string(255)
#  lastname        :string(255)
#  password        :string(255)
#  email           :string(255)
#  billing_info_id :integer
#  address_id      :integer
#  cart_id         :integer
#  admin           :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :address_id, :admin, :billing_info_id, :cart_id, :email, :firstname, :lastname, :password
  has_one :billing_info
  has_one :address
  has_one :cart
end
