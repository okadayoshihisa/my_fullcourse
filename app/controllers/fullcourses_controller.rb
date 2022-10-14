class FullcoursesController < ApplicationController
  skip_before_action :require_login

  def index
    @fullcourses = Fullcourse.all.order(updated_at: :desc).page(params[:page])
  end

  def show
    @fullcourse = Fullcourse.find(params[:id])
    @user = @fullcourse.user
    @fullcourse_menus = FullcourseMenu.where(user_id: @user.id).order(id: :asc)
  end
end
