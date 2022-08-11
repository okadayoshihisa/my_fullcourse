class StarsController < ApplicationController
  def create
    @fullcourse = Fullcourse.find(params[:fullcourse_id])
    current_user.star(@fullcourse)
  end

  def destroy
    @fullcourse = current_user.stars.find(params[:id]).fullcourse
    current_user.delete_star(@fullcourse)
  end
end
