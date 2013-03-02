# == Schema Information
#
# Table name: quantities
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  item_id    :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quantity < ActiveRecord::Base
  belongs_to :cart

  attr_accessible :quantity

  has_one :item
end
