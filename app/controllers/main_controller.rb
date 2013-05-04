class MainController < ApplicationController

  def home
    @title = "ShopOO"
    @items = Item.all
  end

  def about
  end

  def contact
  end

  def admin
    if !current_user.admin?
      redirect_to root_path
    end
    @user = current_user
  end
end
