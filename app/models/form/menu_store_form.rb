class Form::MenuStoreForm
  include ActiveModel::Model
  FORM_COUNT = 8
  attr_accessor :fullcourse_menus, :stores

  def initialize(attributes = {}, user: nil)
    if user.present?
      self.fullcourse_menus = FullcourseMenu.where(user_id: user).order(id: :asc)
      self.stores = self.fullcourse_menus.map(&:store)
    else
      super attributes
      self.stores = FORM_COUNT.times.map { Store.new } unless stores.present?
      self.fullcourse_menus = FORM_COUNT.times.map { FullcourseMenu.new } unless fullcourse_menus.present?
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
        menu.save
        menu.errors.any?
      end
      #エラーを全て出すためsave!は使わずここでエラーを出す
      raise ActiveRecord::RecordInvalid if store_errors.include?(true) || menu_errors.include?(true)
    end
    true
  rescue => e
    false
  end

  def update(params)
    ActiveRecord::Base.transaction do
      store_errors = stores.map.with_index do |store, index|
        store.update(params[:stores_attributes][:"#{index}"])
        store.errors.any?
      end
      menu_errors = fullcourse_menus.map.with_index do |menu, index|
        menu.update(params[:fullcourse_menus_attributes][:"#{index}"])
        menu.errors.any?
      end
      raise ActiveRecord::RecordInvalid if store_errors.include?(true) || menu_errors.include?(true)
    end
    true
  rescue => e
    false
  end
end
