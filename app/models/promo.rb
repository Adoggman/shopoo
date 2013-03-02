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
  attr_accessible :code, :discount

  has_one :item
end
