class PromosController < ApplicationController

  def new
    @title = "Add Promo"
    @promo = Promo.new
  end

  def create
    @promo = Promo.create(params[:promo])
    if @promo.save
      redirect_to :action => :browse
    else
      redirect_to :action => :browse
  end
end

  def browse
    @title = "Browse"
    @promos = Promo.all
  end

  def view
    @promo = Promo.find(params[:id])
  end

end
