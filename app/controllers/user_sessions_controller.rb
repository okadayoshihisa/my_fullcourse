class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to fullcourses_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, success: t('.success')
  end

  def guest_login
    if current_user
      redirect_to fullcourses_path, alert: t('.fail')
    else
      random_value = SecureRandom.hex
      user = User.create!(name: 'ゲストユーザー',
                          email: "#{random_value}@example.com",
                          password: random_value,
                          password_confirmation: random_value,
                          guest: true)
      auto_login(user)
      redirect_to fullcourses_path, success: t('.success')
    end
  end
end
