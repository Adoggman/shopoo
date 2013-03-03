class ItemsController < ApplicationController
  def browse
    @items = Item.all
  end

  def new
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

  def edit
  end
end
