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

  def add_user_id_genre(current_user)
    enum = -1
    fullcourse_menus.map do |x|
      x.user_id = current_user.id
      x.genre = enum += 1
    end
  end
end
