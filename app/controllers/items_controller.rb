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
    if not signed_in?
      flash[:error] = "Please sign in or register to view your cart."
      redirect_to '/signin'
    else
      @title = "Cart"
      @user = current_user
      @cart = @user.cart
      @items = @cart.items.order("id").all
      @promos = @cart.promos.order("id").all
      @promo = nil
    end
  end

  def checkout
    if not signed_in?
      flash[:error] = "Please sign in or register to view your cart."
      redirect_to '/signin'
    elsif current_user.billing_info.incomplete?
      flash[:success] = "Please enter billing info then continue checking out"
      redirect_to "/profile/#{current_user.id}/billing"
    elsif current_user.address.incomplete?
      flash[:success] = "Please enter shipping info then continue checking out"
      redirect_to "/profile/#{current_user.id}/edit"
    else
      @title = "Checkout"
      @user = current_user
      @cart = @user.cart
      @items = @cart.items.order("id").all
      @promos = @cart.promos.order("id").all
      @tax = 0.029
      if @user.billing_info.address.state == "WI"
        @tax = 0.055
      end
    end
  end

  def finalize_checkout
    if not signed_in? then
      flash[:error] = "Please sign in or register to view your cart."
      redirect_to '/signin'
    elsif current_user.billing_info.incomplete? then
      flash[:success] = "Please enter billing info then continue checking out"
      redirect_to "/profile/#{current_user.id}/billing"
    elsif current_user.address.incomplete? then
      flash[:success] = "Please enter shipping info then continue checking out"
      redirect_to "/profile/#{current_user.id}/edit"
    else
      @title = "Finalize Checkout"
      @user = current_user
      @cart = @user.cart
      @total = @cart.get_total
      @tax = 0.029
      if @user.billing_info.address.state == "WI"
        @tax = 0.055
      end
      @total = @total * (1+@tax)
      @cart.clear
      flash[:success] = "Thanks for shopping #{@user.firstname}!."
      redirect_to "/browse"
    end
  end

  def add_promo
    @promo = Promo.find_by_code(params[:promo][:code])
    if @promo == nil
      flash[:error] = "Promo code not found"
    else
      current_user.cart.add_promo(@promo.code)
      flash[:success] = "Promo code added to cart"
    end
    redirect_to "/cart"
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

  def update_quantity
    @quantity = Quantity.find_by_id(params[:quantity][:id])
    if @quantity.update_attributes(params[:quantity])
      flash[:success] = "#{@quantity.item.name} updated."
    else
      flash[:error] = "Editing failed."
    end
    redirect_to "/cart"
  end

  def view
    @item = Item.find(params[:id])
  end
end
