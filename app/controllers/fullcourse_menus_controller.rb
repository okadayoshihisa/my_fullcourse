class FullcourseMenusController < ApplicationController
  def index
    @fullcourse_menus = FullcourseMenu.all
  end

  def new
    byebug
    @form = Form::FullcourseMenuCollection.new
  end

  def create
    byebug
    @form = Form::FullcourseMenuCollection.new(fullcourse_menu_collection_params)
    @form.fullcourse_menus.map do |x|
      x.user_id = current_user.id
      x.genre = 'n'
    end
    if @form.save
      redirect_to fullcourse_menus_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def fullcourse_menu_collection_params
    params.require(:form_fullcourse_menu_collection).permit(fullcourse_menus_attributes: :name)
  end
end
