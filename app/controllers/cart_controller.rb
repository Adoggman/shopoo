class CartController < ApplicationController
  def view

  end

  def create
    @item = Item.new(params[:item])
    @item.save
  end
end
