class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_credentials(*params[:user].values)

    if user
      login!(user)
      redirect_to dragons_url
    else
      flash[:errors] = "incorrect username or password"
      render :new
    end
  end

  def destroy
    logout!
    render :new
  end
end
