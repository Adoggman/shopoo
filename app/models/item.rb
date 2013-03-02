class Item < ActiveRecord::Base
  attr_accessible :cost, :description, :stock, :url
end
