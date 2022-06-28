class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create] 

  def new
  end

  def create
    byebug
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to fullcourse_menus_path, notice: 'Login successful'
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
