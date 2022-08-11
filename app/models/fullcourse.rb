class Fullcourse < ApplicationRecord
  belongs_to :user

  mount_uploader :fullcourse_image, FullcourseImageUploader

  def create_fullcourse_image(user)
    image = MiniMagick::Image.open('./app/assets/images/fullcourse.jpeg')
    pos = '10, 5' # 基準点からの変位'横,縦'
    menus = user.fullcourse_menus.order(id: :asc)
    image.combine_options do |config|
      config.font './app/assets/fonts/GenEiGothicP-Regular.ttf' # フォント指定
      config.fill '#000000' # 色指定ブラック
      config.gravity 'NorthWest' # 基準点指定
      config.pointsize 30 # フォントのサイズ
      config.stroke '#FFFFFF'
      config.strokewidth 6
      config.draw "text #{pos} '#{user.name} フルコースメニュー'"
      config.stroke '#000000'
      config.strokewidth 0
      config.draw "text #{pos} '#{user.name} フルコースメニュー'"

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
