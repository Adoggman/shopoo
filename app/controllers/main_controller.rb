class MainController < ApplicationController

  def home
    @title = "ShopOO"
    @items = Item.paginate(:page => params[:page],
                                        :per_page => 8)
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
