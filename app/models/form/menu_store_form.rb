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
      errors = fullcourse_menus.map.with_index do |menu, i|
        # store.saveしてないので、作成失敗時に入力値を返すために＠form.storesに入れる
        stores[i] = Store.find_or_create_by(name: stores[i].name, address: stores[i].address, latitude: stores[i].latitude,
                                            longitude: stores[i].longitude, phone_number: stores[i].phone_number)
        menu.store_id = stores[i].id
        # 捕獲レベル算出
        menu.level = menu.calculate_level if menu.name.present?
        menu.save
        menu.errors.any? || stores[i].errors.any?
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
      errors = fullcourse_menus.map.with_index do |menu, i|
        store = params[:stores_attributes][:"#{i}"]
        # 緯度経度はfloat型なのでfind_byするために""の時にnilにする
        store[:latitude] = nil if store[:latitude].blank?
        store[:longitude] = nil if store[:longitude].blank?
        # storeはupdateしてないので、更新失敗時に入力値を返すために＠form.storesに入れる
        stores[i] = Store.find_or_create_by(name: store[:name], address: store[:address], latitude: store[:latitude],
                                            longitude: store[:longitude], phone_number: store[:phone_number])
        menu.store_id = stores[i].id
        menu.level = menu.calculate_level if menu.name.present?
        menu.update(params[:fullcourse_menus_attributes][:"#{i}"])
        menu.errors.any? || stores[i].errors.any?
      end
      raise ActiveRecord::RecordInvalid if errors.include?(true)
    end
    true
  rescue StandardError
    false
  end
end
