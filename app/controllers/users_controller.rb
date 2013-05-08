class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index, :destroy]
  before_filter :admin_user,   :only => :destroy

  def index
    @title = "Registered Users"
    @users = User.paginate(:page => params[:page],
                           :per_page => 10)
  end

  def orders
    @title = "View Orders"
    @user = User.find(params[:id])
    @orders = @user.orders.paginate(:page => params[:page], :per_page => 1)
  end

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
      @cart.update_attribute :user_id, @user.id
      @user.update_attribute :address_id, @shipping_address.id
      @user.update_attribute :billing_info_id, @billing_info.id
      @billing_info.update_attribute :address_id, @billing_address.id

      sign_in @user
      flash[:success] = "Welcome to ShopOO!"
      redirect_to profile_path(@user)
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
    @address = Address.find(@user.address_id)
  end

  def billing
    @title = "Edit Billing"
    @user = User.find(params[:id])
    @billing_info = @user.billing_info
    @billing_address = @billing_info.address
  end

  def update_billing
    @user = current_user
    @billing_info = @user.billing_info

    card = params[:billing_info][:cardnumber]
    isValidCard = card.creditcard?(card.creditcard_type.downcase)

    if isValidCard && @billing_info.update_attributes(params[:billing_info])
      @billing_info.build_address
      flash[:success] = "Profile updated."
      redirect_to profile_path(@user)
    else
      @title = "Edit Billing"
      redirect_to billing_path(@user), :notice => "Invalid Card"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      @user.build_address
      flash[:success] = "Profile updated."
      redirect_to profile_path
    else
      @title = "Edit User"
      render 'edit'
    end
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
    flash[:success] = "#{Item.find(@itemid).name} removed."
    redirect_to '/cart'
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end


  private

    def authenticate
      deny_access unless signed_in?
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
