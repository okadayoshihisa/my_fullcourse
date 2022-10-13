class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update image_destroy destroy]
  def show
    @fullcourse_menus = @user.fullcourse_menus.order(id: :asc)
  end

  def edit
    redirect_to profile_path, danger: t('defaults.message.guest_user_limit') if @user.guest?
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
  end

  def image_destroy
    @user.remove_avatar!
    @user.save
  end

  def destroy
    @user.destroy!
    redirect_to fullcourses_path, success: t('.success')
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache)
  end
end
