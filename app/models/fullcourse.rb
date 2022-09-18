class Fullcourse < ApplicationRecord
  belongs_to :user
  has_many :stars, dependent: :destroy

  validates :fullcourse_image, presence: true

  mount_uploader :fullcourse_image, FullcourseImageUploader

  def create_fullcourse_image
    n = rand(1..3)
    image = MiniMagick::Image.open("./app/assets/images/fullcourse#{n}.jpg")
    pos = '10, 10' # 基準点からの変位 '横,縦'
    menus = user.fullcourse_menus.order(id: :asc)
    image.combine_options do |config|
      # 〇〇 フルコースと書き出す
      write_user_name(config, pos)
      menus.each.with_index do |menu, i|
        x = 10
        y = 70 + (70 * i)
        # メニュー、店名を書き出す
        write_menu_store(config, menu, x, y)
        # メニューがないときは空欄を表示
        blank_box(config, x, y) if menu.name.blank?
      end
      write_lines(config, menus)
    end
    image.format 'jpg' # 拡張子を指定
    self.fullcourse_image = image
    save
  end

  # 〇〇 フルコースと書き出す
  def write_user_name(config, pos)
    config.font './app/assets/fonts/GenEiGothicP-Regular.ttf' # フォント指定
    config.fill '#000000' # 色指定ブラック
    config.gravity 'NorthWest' # 基準点指定
    config.pointsize 35 # フォントのサイズ
    config.stroke '#FFFFFF' # 縁の色
    config.strokewidth 6 # 縁の幅
    config.draw "text #{pos} '#{user.name} フルコースメニュー'"
    config.stroke '#000000'
    config.strokewidth 0
    config.draw "text #{pos} '#{user.name} フルコースメニュー'" # 縁取りした文字の上に通常の文字を重ねる
  end

  # メニュー、店名を書き出す
  def write_menu_store(config, menu, x, y)
    config.pointsize 30 # フォントのサイズ
    menu_level = "(#{FullcourseMenu.human_attribute_name(:level)}#{menu.level})"
    # 縁取りメニュー
    config.stroke '#FFFFFF'
    config.strokewidth 6
    config.draw "text #{x}, #{y} '■#{menu.genre_i18n}'"
    config.draw "text #{x + 220}, #{y} '#{menu.name}#{menu_level}'" if menu.name.present?
    # 縁取り店名
    config.pointsize 20
    config.draw "text #{x + 220}, #{y + 35} '#{menu.store.name}'"
    # メニュー
    config.pointsize 30
    config.stroke '#000000'
    config.strokewidth 0
    config.draw "text #{x}, #{y} '■#{menu.genre_i18n}'"
    config.draw "text #{x + 220}, #{y} '#{menu.name}#{menu_level}'" if menu.name.present?
    # 店名
    config.pointsize 20
    config.draw "text #{x + 220}, #{y + 35} '#{menu.store.name}'"
  end

  # 空欄を表示
  def blank_box(config, x, y)
    config.stroke '#FFFFFF'
    config.strokewidth 4 # 白縁
    config.draw "rectangle #{x + 220},#{y - 5} #{x + 450},#{y + 40}"
    config.fill '#FFFFFF'
    config.stroke '#000000' # 黒縁、中白
    config.strokewidth 1
    config.draw "rectangle #{x + 220},#{y - 5} #{x + 450},#{y + 40}"
    config.fill '#000000'
  end

  # セリフ
  def write_lines(config, menus)
    config.font './app/assets/fonts/GenEiAntiqueNv5-M.ttf'
    remaining = menus.map(&:name).count('')
    word1 = remaining == 0 ? "これで完成だ" : "あと#{remaining}つかな"
    word2 = 'お前は？'
    config.gravity 'NorthEast'
    config.strokewidth 0
    config.pointsize 35
    word1.chars.each.with_index do |c, i|
      # ３文字目の時にx方向の数値を変える
      x = word1 == "あと#{remaining}つかな" && i == 2 ? 27 : 20
      y = 50 + (35 * i)
      config.draw "text #{x}, #{y} '#{c}'"
    end
    config.pointsize 30
    word2.chars.each.with_index do |c, i|
      pos = "20, #{500 + (30 * i)}"
      config.draw "text #{pos} '#{c}'"
    end
  end
end
