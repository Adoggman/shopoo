# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cart < ActiveRecord::Base

  belongs_to :user
  has_many :cart_promos
  has_many :quantities
  has_many :promos, :through =>  :cart_promos
  has_many :cart_promos
  has_many :items, :through  => :quantities
  attr_accessible :order_date

  def get_item_quantity(item_id)
    q = Quantity.find_by_cart_id_and_item_id(self.id, item_id)
    if (q==nil) then
      return 0
    else
      return q.quantity
    end
  end

  def get_quantity_by_item_id(item_id)
    return Quantity.find_by_cart_id_and_item_id(self.id, item_id)
  end

  def edit_quantity(item_id, amount)
    if Quantity.find_all_by_cart_id_and_item_id(self.id, item_id).count == 0
      return false
    end
    quantity = Quantity.find_by_cart_id_and_item_id(self.id, item_id)
    quantity.update_column(:quantity, amount)
    return true
  end

  def get_total()
    total = 0
    for item in items
      total += item.cost * get_item_quantity(item.id)
    end
    for promo in promos
      if (!promo.is_valid_promo?)
        next
      elsif (promo.item == nil)
        total = total * (1.0 - promo.discount)
      elsif  items.include? promo.item
        total -= (promo.item.cost * promo.discount)*get_item_quantity(promo.item.id)
      end
    end
    return total
  end

  def get_total_before_promos()
    total = 0
    for item in items
      total += item.cost * get_item_quantity(item.id)
    end
    return total
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
    if (!promo.is_valid_promo?)
      return false
    end
    cart_promo = CartPromo.new
    cart_promo.cart = self
    cart_promo.promo = promo
    cart_promo.save
    return true
  end

  def remove_promo(promo_id)
    cart_promo = CartPromo.find_by_cart_id_and_promo_id(self.id, promo_id)
    cart_promo.delete
  end

  def checkout
    self.order_date = Time.now
    self.save
  end

  def clear
    CartPromo.find_all_by_cart_id(self.id).each do |p|
      p.delete
    end
    Quantity.find_all_by_cart_id(self.id).each do |q|
      q.delete
    end
  end

end
