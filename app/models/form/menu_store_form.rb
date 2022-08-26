class Form::MenuStoreForm
  include ActiveModel::Model
  FORM_COUNT = 8
  attr_accessor :fullcourse_menus, :stores

  def initialize(attributes = {}, user: nil)
    if user.present?
      self.fullcourse_menus = FullcourseMenu.where(user_id: user).order(id: :asc)
      self.stores = fullcourse_menus.map(&:store)
    else
      super attributes
      self.stores = FORM_COUNT.times.map { Store.new } if stores.blank?
      self.fullcourse_menus = FORM_COUNT.times.map { FullcourseMenu.new } if fullcourse_menus.blank?
    end
  end

  # 上でsuper attributesとしているので必要
  def fullcourse_menus_attributes=(attributes)
    self.fullcourse_menus = attributes.map { |_, v| FullcourseMenu.new(v) }
  end

  def stores_attributes=(attributes)
    self.stores = attributes.map { |_, v| Store.new(v) }
  end

  def save
    # 複数件全て保存できた場合のみ実行したいので、transactionを使用する
    ActiveRecord::Base.transaction do
      store_errors = stores.map do |store|
        store.save
        store.errors.any?
      end
      menu_errors = fullcourse_menus.map.with_index do |menu, index|
        menu.store_id = stores[index].id
        # 捕獲レベル算出
        menu.level = menu.calculate_level if menu.name.present?
        menu.save
        menu.errors.any?
      end
      # エラーを全て出すためsave!は使わずここでエラーを出す
      raise ActiveRecord::RecordInvalid if store_errors.include?(true) || menu_errors.include?(true)
    end
    true
  rescue StandardError
    false
  end

  def update(params)
    ActiveRecord::Base.transaction do
      store_errors = stores.map.with_index do |store, index|
        store.update(params[:stores_attributes][:"#{index}"])
        store.errors.any?
      end
      menu_errors = fullcourse_menus.map.with_index do |menu, index|
        menu.level = menu.calculate_level if menu.name.present?
        menu.update(params[:fullcourse_menus_attributes][:"#{index}"])
        menu.errors.any?
      end
      raise ActiveRecord::RecordInvalid if store_errors.include?(true) || menu_errors.include?(true)
    end
    true
  rescue StandardError
    false
  end
end
