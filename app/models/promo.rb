class Promo < ActiveRecord::Base
  attr_accessible :code, :discount

  has_one :item
end
