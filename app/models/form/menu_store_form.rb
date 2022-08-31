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
    self.stores = attributes.map { |_, v| Store.find_or_initialize_by(name: v[:name], address: v[:address]) }
  end

  def save
    # 複数件全て保存できた場合のみ実行したいので、transactionを使用する
    ActiveRecord::Base.transaction do
      errors = fullcourse_menus.map.with_index do |menu, index|
        # store.saveしてないので、作成失敗時に入力値を返すために＠form.storesに入れる
        stores[index] = Store.find_or_create_by(name: stores[index].name, address: stores[index].address)
        menu.store_id = stores[index].id
        # 捕獲レベル算出
        menu.level = menu.calculate_level if menu.name.present?
        menu.save
        menu.errors.any? || stores[index].errors.any?
      end
      # エラーを全て出すためsave!は使わずここでエラーを出す
      raise ActiveRecord::RecordInvalid if errors.include?(true)
    end
    true
  rescue StandardError
    false
  end

  def update(params)
    ActiveRecord::Base.transaction do
      errors = fullcourse_menus.map.with_index do |menu, index|
        # storeはupdateしてないので、更新失敗時に入力値を返すために＠form.storesに入れる
        stores[index] = Store.find_or_create_by(name: params[:stores_attributes][:"#{index}"][:name], address: params[:stores_attributes][:"#{index}"][:address])
        menu.store_id = stores[index].id
        menu.level = menu.calculate_level if menu.name.present?
        menu.update(params[:fullcourse_menus_attributes][:"#{index}"])
        menu.errors.any? || stores[index].errors.any?
      end
      raise ActiveRecord::RecordInvalid if errors.include?(true)
    end
    true
  rescue StandardError
    false
  end
end
