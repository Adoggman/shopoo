class MainController < ApplicationController

  def home
    @title = "ShopOO"
    @items = Item.all
  end

  def about
  end

  def contact
  end
end
