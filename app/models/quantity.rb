class Quantity < ActiveRecord::Base
  belongs_to :cart

  attr_accessible :quantity

  has_one :item
end
