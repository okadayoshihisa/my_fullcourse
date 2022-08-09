class FullcourseMenusController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_user, only: %i[edit update]

  def index
    @fullcourse_menus = FullcourseMenu.all
  end

  def new
    redirect_to edit_fullcourse_menu_path(current_user.id) if current_user.fullcourse_menus.present?
    @form = Form::FullcourseMenuCollection.new
  end

  def create
    @form = Form::FullcourseMenuCollection.new(fullcourse_menu_collection_params)
    @form.fullcourse_menus.map { |x| x.user_id = current_user.id }
    if @form.save
      @user.create_fullcourse_image
      redirect_to fullcourses_path
    else
      render :new
    end
  end

  def show; end

  def edit
    redirect_to fullcourses_path unless @user == current_user
    gon.lat = @user.fullcourse_menus.order(id: :asc).map { |menu| menu.store.latitude }
    gon.lng = @user.fullcourse_menus.order(id: :asc).map { |menu| menu.store.longitude }
    gon.user = @user
  end

  def update
    if @user.multi_update(edit_fullcourse_menu_params)
      @user.create_fullcourse_image
      redirect_to fullcourses_path
    else
      render :edit
    end
  end

  def destroy; end

  private

  def fullcourse_menu_collection_params
    params.require(:form_fullcourse_menu_collection).permit(fullcourse_menus_attributes: %i[name genre menu_image menu_image_cache],
                                                            stores_attributes: %i[name address latitude longitude])
  end

  def edit_fullcourse_menu_params
    params.require(:user).permit(fullcourse_menus: %i[name genre menu_image menu_image_cache],
                                 stores: %i[name address latitude longitude])
  end

  def set_user
    @user = User.includes(fullcourse_menus: :store).find(params[:id])
  end
end
