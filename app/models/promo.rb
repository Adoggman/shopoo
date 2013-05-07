# == Schema Information
#
# Table name: promos
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  item_id    :integer
#  discount   :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Promo < ActiveRecord::Base
  attr_accessible :code, :discount, :item_id, :expiration
  belongs_to :item
  has_one :cart_promo

  def is_valid_promo?
    return expiration.nil? || DateTime.now < self.expiration
  end

  def check_valid (date)
    if date.nil?
      return is_valid_promo?
    else
      return date <= self.expiration
    end
  end

end
