class ItemsController < ApplicationController

  def new
    @title = "Add Item"
    @item = Item.new
  end

  def create
    @item = Item.create(params[:item])
    if @item.save
      redirect_to :action => :browse
    else
      redirect_to :action => :browse
    end
  end

  def browse
    @title = "Browse"
    @items = Item.all
  end

  def cart
    @title = "Cart"
    @items = current_user.cart.items
  end

  def edit
    @title = "Edit"
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to :action => :browse
    else
      render 'edit'
    end
  end
end
