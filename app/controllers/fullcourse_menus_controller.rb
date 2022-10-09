class FullcourseMenusController < ApplicationController
  skip_before_action :require_login, only: %i[index map index]
  before_action :set_user, only: %i[edit update]

  def index
    @q = FullcourseMenu.where.not(name: '').order(updated_at: :desc).ransack(search_params)
    @fullcourse_menus = @q.result(distinct: true).page(params[:page])
  end

  def new
    if current_user.fullcourse_menus.present?
      redirect_to edit_fullcourse_menu_path(current_user.id)
    else
      @form = MenuStoreForm.new
    end
  end

  def create
    @form = MenuStoreForm.new(user_id_merge_form_params)
    if @form.save
      current_user.create_fullcourse(fullcourse_image: CreateFullcourseImage.call(current_user))
      redirect_to fullcourse_path(current_user)
    else
      gon.lat = menu_store_form_params[:stores_attributes].to_h.map { |store| store[1][:latitude].to_f }
      gon.lng = menu_store_form_params[:stores_attributes].to_h.map { |store| store[1][:longitude].to_f }
      render :new
    end
  end

  def show
    @fullcourse_menu = FullcourseMenu.find(params[:id])
    gon.menu = @fullcourse_menu
    gon.id = gon.menu.id
    gon.latlng = { lat: gon.menu.store.latitude, lng: gon.menu.store.longitude }
  end

  def edit
    if @user == current_user
      @form = MenuStoreForm.new(user: @user)
      gon.lat = @user.fullcourse_menus.order(id: :asc).map { |menu| menu.store.latitude }
      gon.lng = @user.fullcourse_menus.order(id: :asc).map { |menu| menu.store.longitude }
      gon.user_id = @user.id
    else
      redirect_to fullcourses_path
    end
  end

  def update
    @form = MenuStoreForm.new(user: @user)
    if @form.update(menu_store_form_params)
      fullcourse = @user.fullcourse
      fullcourse.update(fullcourse_image: CreateFullcourseImage.call(@user))
      redirect_to fullcourse_path
    else
      gon.lat = menu_store_form_params[:stores_attributes].to_h.map { |store| store[1][:latitude].to_f }
      gon.lng = menu_store_form_params[:stores_attributes].to_h.map { |store| store[1][:longitude].to_f }
      gon.user_id = @user.id
      render :edit
    end
  end

  def map
    menus = FullcourseMenu.all
    gon.lat = menus.map { |menu| menu.store.latitude }
    gon.lng = menus.map { |menu| menu.store.longitude }
    gon.menus = menus.as_json(include: { store: { only: [:name] } })
  end

  def image_destroy
    @index = params[:index]
    if current_user.fullcourse_menus.present?
      @fullcourse_menu = FullcourseMenu.find(params[:id])
      @fullcourse_menu.remove_menu_image!
      @fullcourse_menu.save
    else
      @fullcourse_menu = FullcourseMenu.new
    end
  end

  private

  def menu_store_form_params
    params.require(:menu_store_form).permit(fullcourse_menus_attributes: %i[name genre menu_image menu_image_cache],
                                            stores_attributes: %i[name address latitude longitude phone_number])
  end

  def set_user
    @user = User.includes(fullcourse_menus: :store).find(params[:id])
  end

  def user_id_hash
    menus_user_id = menu_store_form_params[:fullcourse_menus_attributes].to_h.map.with_index do |menu, index|
      [index.to_s, menu[1].merge(user_id: current_user.id)]
    end
    menus_user_id.to_h
  end

  def user_id_merge_form_params
    user_id_merge_form_params = menu_store_form_params
    user_id_merge_form_params[:fullcourse_menus_attributes].merge!(user_id_hash)
    user_id_merge_form_params
  end

  def search_params
    params[:q]&.permit(:name_cont, :store_name_cont, :store_address_cont, :genre_eq)
  end
end
