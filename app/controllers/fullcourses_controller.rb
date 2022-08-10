class FullcoursesController < ApplicationController
  skip_before_action :require_login

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @fullcourse_menus = FullcourseMenu.where(user_id: params[:id]).order(id: :asc)
  end
end
