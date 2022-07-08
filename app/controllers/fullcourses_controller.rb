class FullcoursesController < ApplicationController
  before_action :set_user, only: %i[index]

  def index
    @users = User.all
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end
end
