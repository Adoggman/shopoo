# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  cost        :decimal(, )
#  description :string(255)
#  stock       :integer
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Item < ActiveRecord::Base
  attr_accessible :cost, :description, :stock, :url
end
