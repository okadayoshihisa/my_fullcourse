class Form::FullcourseMenuCollection < Form::Base
  FORM_COUNT = 2
  attr_accessor :fullcourse_menus

  def initialize(attributes = {})
    super attributes
    self.fullcourse_menus = FORM_COUNT.times.map { FullcourseMenu.new } unless fullcourse_menus.present?
  end

  # 上でsuper attributesとしているので必要
  def fullcourse_menus_attributes=(attributes)
    self.fullcourse_menus = attributes.map { |_, v| FullcourseMenu.new(v) }
  end

  def save
    # 実際にやりたいことはこれだけ
    # self.memos.map(&:save!)

    # 複数件全て保存できた場合のみ実行したいので、transactionを使用する
    FullcourseMenu.transaction do
      fullcourse_menus.map(&:save!)
    end
    true
  rescue StandardError => e
    false
  end

  def add_user_id(current_user)
    fullcourse_menus.map do |x|
      x.user_id = current_user.id
    end
  end

  def create_fullcourse_image(user)
    image = MiniMagick::Image.open('./app/assets/images/fullcourse.jpeg')
    pos = '10, 75'    # 基準点からの変位'横,縦'
    fullcourse_menus.map do |x|
      text = "#{x.name}"       # 入れる文字列
      image.combine_options do |config|
        config.font './app/assets/fonts/genshingothic-20150607/GenShinGothic-Heavy.ttf'   # フォント指定
        config.fill '#FFFFFF'    # 色指定
        config.gravity 'NorthWest'  # 基準点指定
        config.pointsize 30      # フォントのサイズ
        config.draw "text #{pos} '#{text}'"
      end
      image.combine_options do |config|
        config.font './app/assets/fonts/genshingothic-20150607/GenShinGothic-Regular.ttf'   # フォント指定
        config.fill '#000000'    # 色指定
        config.gravity 'NorthWest'  # 基準点指定
        config.pointsize 30      # フォントのサイズ
        config.draw "text #{pos} '#{text}'"
      end
      image.format 'jpg'       # 拡張子を指定
      image.write "./public/uploads/fullcourse#{x.user_id}.jpg" # 指定したファイル名で出力  
      user.fullcourse_image = image.path #画像のパスをUserのfullcourse_imageカラムへ保存
      user.save
    end
  end
end
