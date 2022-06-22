class UserSessionsController < ApplicationController
  def new
  end

  def create
    byebug
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to login_path, notice: 'Login successful'
    else
      flash.now[:alert] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: 'Logged out!'
  end
end
