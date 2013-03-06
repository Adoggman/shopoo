class SessionsController < ApplicationController

  def new
    @title = "Sign In"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])

    if user.nil?
      # use flash.now instead of just flash because flash waits for a redirect to disappear,
      # and we are simply rendering the page on failure, not redirecting
      flash.now[:error] = "Invalid email and/or password."
      @title = "Sign In"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
