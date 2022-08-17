# app/controllers/oauths_controller.rb
class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(params[:provider])
  end
      
  def callback
    provider = params[:provider]
    if auth_params[:denied].present?
      redirect_to login_path, danger: t('defaults.message.cancel', item: t('defaults.login'))
      return
    end
    create_user_from(provider) unless (@user = login_from(provider))
    redirect_to fullcourses_path, success: t('user_sessions.create.success')
  end

  private

  def auth_params
    params.permit(:code, :provider, :denied)
  end

  def create_user_from(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end