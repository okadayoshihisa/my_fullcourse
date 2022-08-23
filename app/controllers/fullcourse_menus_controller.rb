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
    @form = Form::MenuStoreForm.new(user_id_merge_form_params)
    if @form.save
      fullcourse = current_user.build_fullcourse
      fullcourse.create_fullcourse_image
      redirect_to fullcourses_path
    else
      gon.lat = menu_store_form_params[:stores_attributes].to_h.map { |store| store[1][:latitude].to_f }
      gon.lng = menu_store_form_params[:stores_attributes].to_h.map { |store| store[1][:longitude].to_f }
      gon.user = @user
      render :new
    end
  end

  def show; end

  def edit
    redirect_to fullcourses_path unless @user == current_user
    @form = Form::MenuStoreForm.new(user: @user)
    gon.lat = @user.fullcourse_menus.order(id: :asc).map { |menu| menu.store.latitude }
    gon.lng = @user.fullcourse_menus.order(id: :asc).map { |menu| menu.store.longitude }
    gon.user = @user
  end

  def update
    @form = Form::MenuStoreForm.new(user: @user)
    if @form.update(menu_store_form_params)
      fullcourse = @user.build_fullcourse
      fullcourse.create_fullcourse_image
      redirect_to fullcourses_path
    else
      gon.lat = menu_store_form_params[:stores_attributes].to_h.map { |store| store[1][:latitude].to_f }
      gon.lng = menu_store_form_params[:stores_attributes].to_h.map { |store| store[1][:longitude].to_f }
      gon.user = @user
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

  def user_id_hash
    menus_user_id = menu_store_form_params[:fullcourse_menus_attributes].to_h.map.with_index do |menu, index|
      ["#{index}", menu[1].merge(user_id: current_user.id)]
    end
    menus_user_id.to_h
  end

  def user_id_merge_form_params
    user_id_merge_form_params = menu_store_form_params
    user_id_merge_form_params[:fullcourse_menus_attributes].merge!(user_id_hash)
    user_id_merge_form_params
  end
end
