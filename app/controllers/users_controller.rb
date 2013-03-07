class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def new
    @title = "Sign Up"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @cart = Cart.new
    @shipping_address = Address.new
    @billing_address = Address.new
    @billing_info = BillingInfo.new

    if @user.save
      @cart.save
      @shipping_address.save
      @billing_address.save
      @billing_info.save
      @user.update_attribute :cart_id, @cart.id
      @user.update_attribute :address_id, @shipping_address.id
      @user.update_attribute :billing_info_id, @billing_info.id
      @billing_info.update_attribute :address_id, @billing_address.id

      sign_in @user
      flash[:success] = "Welcome to ShopOO!"
      redirect_to @user
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @title = "#{@user.firstname} #{@user.lastname}"
  end

  def edit
    @title = "Edit Profile"
    @user = User.find(params[:id])
    @shipping_address = Address.find(@user.address_id)

  end

  def add_item
    @itemid = params[:id]
    @quantity = params[:quantity]
    @user = current_user
    @cart = @user.cart
    if @cart.add_item(@itemid,@quantity)
      flash[:success] = "Item added."
    else
      flash[:error] = "Item is already in cart."
    end
    redirect_to '/cart'
  end

  def remove_item
    @itemid = params[:id]
    @user = current_user
    @cart = @user.cart
    @cart.remove_item(@itemid)
    flash[:success] = "Item removed."
    redirect_to '/cart'
  end

  def update
    @user = User.find(params[:id])
    #@shipping_address =  Address.find(@user.address_id)
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to user_path unless current_user?(@user)
    end
end
