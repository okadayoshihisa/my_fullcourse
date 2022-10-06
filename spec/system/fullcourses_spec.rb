require 'rails_helper'

RSpec.describe 'Fullcourses', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  before do
    login(another_user)
    create_menus
    click_link('dropdownUser1')
    click_link('ログアウト')
    login(user)
    create_menus
  end
  describe 'フルコース一覧表示機能' do
    before { visit fullcourses_path }
    context 'フルコース作成済みの時' do
      it 'すべてのフルコースが表示される' do
        expect(page).to have_content(user.name)
        expect(page).to have_content(another_user.name)
        expect(page.all('img.card-img-top').count).to eq 2
      end
    end
    context '作成者が他のユーザーの時' do
      it 'フルコースメニュー編集ボタンが表示されない' do
        expect(page).to_not have_css("a#button-edit-#{another_user.id}")
      end
    end
  end

  describe 'フルコース詳細表示機能' do
    context 'フルコース一覧の画像をクリックした時' do
      it 'フルコース画像と登録したメニューが表示されること' do
        visit fullcourses_path
        click_link("fullcourse-img-#{user.id}")
        expect(page).to have_css('img.d-block.mx-auto.img-fluid')
        expect(page).to have_content('test_zensai')
        expect(page).to have_content('test_soup')
        expect(page).to have_content('test_fish')
        expect(page).to have_content('test_meat')
        expect(page).to have_content('test_main')
        expect(page).to have_content('test_salad')
        expect(page).to have_content('test_desert')
        expect(page).to have_content('test_drink')
      end
      context '作成者が他のユーザーの時' do
        it 'フルコースメニュー編集ボタンが表示されない' do
          visit fullcourse_path(another_user.id)
          expect(page).to_not have_css('a.btn.btn-success')
        end
      end
    end
  end
end
