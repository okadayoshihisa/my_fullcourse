require 'rails_helper'

RSpec.describe FullcourseMenu, type: :model do
  context '紐づいたstoreモデルの店名が空欄の場合' do
    it 'メニュー名が空欄かつジャンルが入力されている時登録できること' do
      store_without_name = create(:store, name: '')
      fullcourse_menu_without_name = build(:fullcourse_menu, name: '', store_id: store_without_name.id)
      expect(fullcourse_menu_without_name).to be_valid
    end
  end
  context '紐づいたstoreモデルの店名が入力されている場合' do
    it 'メニュー名とジャンルが入力されている時登録できること' do
      fullcourse_menu = build(:fullcourse_menu)
      expect(fullcourse_menu).to be_valid
    end
    it 'メニュー名が空欄の時登録できないこと' do
      fullcourse_menu_without_name = build(:fullcourse_menu, name: '')
      expect(fullcourse_menu_without_name).to be_invalid
      expect(fullcourse_menu_without_name.errors[:name]).to eq ['を入力してください']
    end
  end
  it 'ジャンルが空欄の時登録できないこと' do
    fullcourse_menu_without_genre = build(:fullcourse_menu, genre: '')
    expect(fullcourse_menu_without_genre).to be_invalid
    expect(fullcourse_menu_without_genre.errors[:genre]).to eq ['を入力してください']
  end
  it '一人のユーザーが９個以上登録できないこと' do
    user = create(:user)
    create_list(:fullcourse_menu, 8, user_id: user.id)
    fullcourse_menu = build(:fullcourse_menu, user_id: user.id)
    expect(fullcourse_menu).to be_invalid
    expect(fullcourse_menu.errors.full_messages).to eq ['登録できるフルコースメニューは8つまでです']
  end
end
