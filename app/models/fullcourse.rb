class Fullcourse < ApplicationRecord
  belongs_to :user
  has_many :stars, dependent: :destroy

  validates :fullcourse_image, presence: true

  mount_uploader :fullcourse_image, FullcourseImageUploader

  def create_fullcourse_image
    image = MiniMagick::Image.open('./app/assets/images/fullcourse.jpeg')
    pos = '10, 5' # 基準点からの変位 '横,縦'
    menus = user.fullcourse_menus.order(id: :asc)
    image.combine_options do |config|
      config.font './app/assets/fonts/GenEiGothicP-Regular.ttf' # フォント指定
      config.fill '#000000' # 色指定ブラック
      config.gravity 'NorthWest' # 基準点指定
      config.pointsize 30 # フォントのサイズ
      config.stroke '#FFFFFF' # 縁の色
      config.strokewidth 6 # 縁の幅
      config.draw "text #{pos} '#{user.name} フルコースメニュー'"
      config.stroke '#000000'
      config.strokewidth 0
      config.draw "text #{pos} '#{user.name} フルコースメニュー'" # 縁取りした文字の上に通常の文字を重ねる

      config.pointsize 25 # フォントのサイズ
      menus.each.with_index do |menu, i|
        # ジャンル、メニューを表示
        pos = 60 * (i + 1)
        config.stroke '#FFFFFF'
        config.strokewidth 6
        config.draw "text 10, #{pos} '■#{menu.genre_i18n}'"
        config.draw "text 180, #{pos} #{menu.name}" if menu.name.present?
        config.stroke '#000000'
        config.strokewidth 0
        config.draw "text 10, #{pos} '■#{menu.genre_i18n}'"
        config.draw "text 180, #{pos} #{menu.name}" if menu.name.present?
        # メニューがないときは空欄を表示
        if menu.name.blank?
          config.stroke '#FFFFFF'
          config.strokewidth 4 # 白縁
          config.draw "rectangle 180,#{pos - 10} 350,#{pos + 40}"
          config.fill '#FFFFFF'
          config.stroke '#000000'
          config.strokewidth 1 # 中が白、縁が黒
          config.draw "rectangle 180,#{pos - 10} 350,#{pos + 40}"
          config.fill '#000000'
        end
      end

      write_lines(config, menus)
    end
    image.format 'jpg' # 拡張子を指定
    self.fullcourse_image = image
    save
  end

  # セリフ
  def write_lines(config, menus)
    config.font './app/assets/fonts/GenEiAntiqueNv5-M.ttf'
    word_1 = "あと#{menus.map(&:name).count("")}つかな"
    word_2 = "お前は？"
    config.gravity 'NorthEast'
    config.strokewidth 0
    config.pointsize 35
    word_1.chars.each.with_index do |c, i|
      # 数字の時はx方向の数値を変える
      i == 2 ? x = 27 : x = 20
      y = 50+(35*i)
      config.draw "text #{x}, #{y} '#{c}'"
    end
    config.pointsize 30
    word_2.chars.each.with_index do |c, i|
      pos = "20, #{500+(30*i)}"
      config.draw "text #{pos} '#{c}'"
    end
  end
end
