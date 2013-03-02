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

class CartPromo < ActiveRecord::Base
  belongs_to :cart
  attr_accessible :cart_id, :promo_id
  has_one :promo
end
