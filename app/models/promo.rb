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
  attr_accessible :code, :discount, :item_id
  belongs_to :item
  has_one :cart_promo


end
