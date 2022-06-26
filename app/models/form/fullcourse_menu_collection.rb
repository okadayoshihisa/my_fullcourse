class Form::FullcourseMenuCollection < Form::Base
  FORM_COUNT = 2
  N = 0
  attr_accessor :fullcourse_menus

  def initialize(attributes = {})
    super attributes
    self.fullcourse_menus = FORM_COUNT.times.map { FullcourseMenu.new(genre: N) } unless self.fullcourse_menus.present?
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
      self.fullcourse_menus.map(&:save!)
    end
      return true
    rescue => e
      return false
  end
end
