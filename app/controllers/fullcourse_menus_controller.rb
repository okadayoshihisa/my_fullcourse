class FullcourseMenusController < ApplicationController
  before_action :set_user, only: %i[create]

  def index
    @fullcourse_menus = FullcourseMenu.all
  end

  def new
    @form = Form::FullcourseMenuCollection.new
  end

  def create
    @form = Form::FullcourseMenuCollection.new(fullcourse_menu_collection_params)
    @form.add_user_id(current_user)
    if @form.save
      @form.create_fullcourse_image(@user)
      redirect_to fullcourses_path
    else
      render :new
    end
  end

  def show; end

  def edit
    @user = User .includes(:fullcourse_menus).find(params[:id])
    redirect_to fullcourses_path unless @user == current_user
  end

  def update
    if FullcourseMenu.multi_update(edit_fullcourse_menu_params)
      redirect_to fullcourses_path
    else
      render :edit
    end
  end

  def destroy; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def fullcourse_menu_collection_params
    params.require(:form_fullcourse_menu_collection).permit(fullcourse_menus_attributes: %i[name genre menu_image
                                                                                            menu_image_cache])
  end

  def edit_fullcourse_menu_params
    params.require(:user).permit(fullcourse_menus: %i[name genre menu_image menu_image_cache])[:fullcourse_menus]
  end

  def check_have_menu
    redirect_to edit_fullcourse_menu_path(current_user.id) if current_user.fullcourse_menus.present?
  end
end
