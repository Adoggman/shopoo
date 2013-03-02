class Cart < ActiveRecord::Base
  has_many :promos, :through =>  :cart_promos
  has_many :items, :through  => :quantities
end
