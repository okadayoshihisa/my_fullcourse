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
    @form.add_user_id_genre(current_user)
    if @form.save
      @form.write_menu(@user)
      redirect_to fullcourse_menus_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def fullcourse_menu_collection_params
    params.require(:form_fullcourse_menu_collection).permit(fullcourse_menus_attributes: %i[name menu_image
                                                                                            menu_image_cache])
  end
end
