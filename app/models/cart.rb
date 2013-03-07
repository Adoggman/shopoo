# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ActiveRecord::Base
  has_one :user
  has_many :cart_promos
  has_many :quantities
  has_many :promos, :through =>  :cart_promos
  has_many :cart_promos
  has_many :items, :through  => :quantities

  def get_item_quantity(item_id)
    return Quantity.find_by_cart_id_and_item_id(self.id, item_id).quantity
  end

  def add_item(item_id, amount)
    if Quantity.find_all_by_cart_id_and_item_id(self.id, item_id).count > 0
        return false
    end
    quantity = Quantity.new
    quantity.cart_id = self.id.to_i
    quantity.item_id = item_id
    quantity.quantity = amount
    quantity.save
    return true
  end

  def remove_item(item_id)
    quantity = Quantity.find_by_cart_id_and_item_id(self.id, item_id)
    quantity.delete
  end

  def update_quantity(item_id, amount)
    quantity = Quantity.find_by_cart_id_and_item_id(self.id, item_id)
    quantity.update_attribute(:quantity, amount)
  end

  def add_promo(promo_code)
    promo = Promo.find_by_code(promo_code)
    cart_promo = CartPromo.new
    cart_promo.cart_id = :id
    cart_promo.promo_id = promo.id
    cart_promo.save
  end

  def remove_promo(promo_id)
    cart_promo = Promo.find_by_cart_id_and_promo_id(self.id, promo_id)
    cart_promo.delete
  end
end
