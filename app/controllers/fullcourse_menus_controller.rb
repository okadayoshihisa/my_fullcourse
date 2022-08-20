class FullcourseMenusController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_user, only: %i[edit update]

  def index
    @fullcourse_menus = FullcourseMenu.all
  end

  def new
    redirect_to edit_fullcourse_menu_path(current_user.id) if current_user.fullcourse_menus.present?
    @form = Form::MenuStoreForm.new
  end

  def create
    debugger
    @form = Form::MenuStoreForm.new(menu_store_form_params)
    @form.fullcourse_menus.map { |x| x.user_id = current_user.id }
    if @form.save
      fullcourse = current_user.build_fullcourse
      fullcourse.create_fullcourse_image(current_user)
      redirect_to fullcourses_path
    else
      render :new
    end
  end

  def show; end

  def edit
    redirect_to fullcourses_path unless @user == current_user
    @form = Form::MenuStoreForm.new(user_id: @user.id)
    gon.lat = @user.fullcourse_menus.order(id: :asc).map { |menu| menu.store.latitude }
    gon.lng = @user.fullcourse_menus.order(id: :asc).map { |menu| menu.store.longitude }
    gon.user = @user
    debugger
  end

  def update
    debugger
    @form = Form::MenuStoreForm.new(user_id: @user.id)
    if @form.update(menu_store_form_params)
      fullcourse = @user.build_fullcourse
      fullcourse.create_fullcourse_image(@user)
      redirect_to fullcourses_path
    else
      render :edit
    end
  end

  def map
    gon.menus = FullcourseMenu.all
    gon.lat = gon.menus.map { |menu| menu.store.latitude }
    gon.lng = gon.menus.map { |menu| menu.store.longitude }
  end

  def destroy; end

  private

  def menu_store_form_params
    params.require(:form_menu_store_form).permit(fullcourse_menus_attributes: %i[name genre menu_image menu_image_cache],
                                                            stores_attributes: %i[name address latitude longitude])
  end

  def set_user
    @user = User.includes(fullcourse_menus: :store).find(params[:id])
  end
end
