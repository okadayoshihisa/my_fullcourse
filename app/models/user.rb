class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :fullcourse_menus, dependent: :destroy

  mount_uploader :fullcourse_image, FullcourseImageUploader

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true
  validates :email, uniqueness: true

  def multi_update(edit_fullcourse_menu_params)
    FullcourseMenu.transaction do
      edit_fullcourse_menu_params[:fullcourse_menus].to_h.map.with_index do |edit_fullcourse_menu_param, index|
        fullcourse_menus.order(id: :asc)[index].update(edit_fullcourse_menu_param[1])
      end
      edit_fullcourse_menu_params[:stores].to_h.map.with_index do |edit_fullcourse_menu_param, index|
        fullcourse_menus.order(id: :asc)[index].store.update(edit_fullcourse_menu_param[1])
      end
    end
    true
  rescue StandardError => e
    false
  end

  def create_fullcourse_image
    image = MiniMagick::Image.open('./app/assets/images/fullcourse.jpeg')
    pos = '10, 5' # 基準点からの変位'横,縦'
    menus = fullcourse_menus.order(id: :asc)
    image.combine_options do |config|
      config.font './app/assets/fonts/GenEiGothicP-Regular.ttf' # フォント指定
      config.fill '#000000' # 色指定ブラック
      config.gravity 'NorthWest' # 基準点指定
      config.pointsize 30 # フォントのサイズ
      config.stroke '#FFFFFF'
      config.strokewidth 6
      config.draw "text #{pos} '#{name} フルコースメニュー'"
      config.stroke '#000000'
      config.strokewidth 0
      config.draw "text #{pos} '#{name} フルコースメニュー'"

      config.pointsize 25 # フォントのサイズ
      menus.each.with_index do |menu, i|
        pos = 60 * (i + 1)
        config.stroke '#FFFFFF'
        config.strokewidth 6
        config.draw "text 10, #{pos} '■#{menu.genre_i18n}'"
        config.stroke '#000000'
        config.strokewidth 0
        config.draw "text 10, #{pos} '■#{menu.genre_i18n}'"
        config.stroke '#FFFFFF'

        if menu.name.present?
          config.strokewidth 6
          config.draw "text 180, #{pos} #{menu.name}"
          config.stroke '#000000'
          config.strokewidth 0
          config.draw "text 180, #{pos} #{menu.name}"
        else
          # メニューないときの空欄
          config.strokewidth 4
          config.draw "rectangle 180,#{pos - 10} 350,#{pos + 40}"
          config.fill '#FFFFFF'
          config.stroke '#000000'
          config.strokewidth 1
          config.draw "rectangle 180,#{pos - 10} 350,#{pos + 40}"
          config.fill '#000000'
        end
      end
    end
    image.format 'jpg' # 拡張子を指定
    self.fullcourse_image = image
    save
  end
end
