class CartPromo < ActiveRecord::Base
  belongs_to :cart
  attr_accessible :cart_id, :promo_id
  has_one :promo
end
