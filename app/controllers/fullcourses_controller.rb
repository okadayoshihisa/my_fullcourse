class FullcoursesController < ApplicationController
  skip_before_action :require_login

  def index
    @fullcourses = Fullcourse.all.order(updated_at: :desc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @fullcourse_menus = FullcourseMenu.where(user_id: params[:id]).order(id: :asc)
  end
end
