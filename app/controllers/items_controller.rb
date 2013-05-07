class ItemsController < ApplicationController
  before_filter :redirect_if_not_admin,   :only => [:new, :edit]

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
    if !params[:query].nil?
      query = params[:query].downcase
      where = ['LOWER(name) LIKE ? or LOWER(category) LIKE ?', '%' + query+ '%', '%' + query + '%']
      @items = Item.paginate(:page => params[:page],
                             :per_page => 8,
                             :conditions => ['LOWER(name) LIKE ? or LOWER(category) LIKE ?', '%' + query+ '%', '%' + query + '%'])
    elsif !params[:category].nil?
      category = params[:category]
      @items = Item.paginate(:page => params[:page],
                             :per_page => 8,
                             :conditions => {:category => category})
    else
      @items = Item.paginate(:page => params[:page],
                             :per_page => 8)
    end
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
      redirect_to signin_path
    elsif current_user.billing_info.incomplete?
      flash[:success] = "Please enter billing info then continue checking out"
      redirect_to billing_path current_user.id
    elsif current_user.address.incomplete?
      flash[:success] = "Please enter shipping info then continue checking out"
      redirect_to edit_profile_path current_user.id
    elsif current_user.cart.items.empty?
      redirect_to root_path
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
      redirect_to signin_path
    elsif current_user.billing_info.incomplete? then
      flash[:success] = "Please enter billing info then continue checking out"
      redirect_to billing_path current_user.id
    elsif current_user.address.incomplete? then
      flash[:success] = "Please enter shipping info then continue checking out"
      redirect_to edit_profile_path current_user.id
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
      @user.checkout
      flash[:success] = "Thanks for shopping #{@user.firstname}!"
      redirect_to root_path
    end
  end

  def add_promo
    @promo = Promo.find_by_code(params[:promo][:code])
    if @promo == nil
      flash[:error] = "Promo code not found"
    else
      if (current_user.cart.add_promo(@promo.code) )
        flash[:success] = "Promo code added to cart"
      else
        flash[:error] = "That promo has expired"
      end
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



  private

  def redirect_if_not_admin
    if !signed_in? || !current_user.admin?
      redirect_to root_path
    end
  end


end
