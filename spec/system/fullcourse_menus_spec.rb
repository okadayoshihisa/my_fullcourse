require 'rails_helper'

RSpec.fdescribe 'FullcourseMenus', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:menu) { create(:fullcourse_menu) }
  let!(:another_menu) { create(:fullcourse_menu) }

  describe '一覧表示機能' do
    context 'フルコースメニューが作成済みの時' do
      it 'すべてのフルコースメニューが表示される' do
        visit fullcourse_menus_path
        expect(page).to have_content(menu.name)
        expect(page).to have_content(another_menu.name)
      end
    end
  end

  describe 'マップ機能' do
    context 'フルコースメニューが作成済みの時' do
      it 'フルコースメニューが表示される' do
        visit map_fullcourse_menus_path
        expect(page).to have_content(menu.name)
        expect(page).to have_content(another_menu.name)
      end
    end
  end

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'フルコースメニュー作成ページにアクセス' do
        it 'アクセスに失敗する' do
          visit new_fullcourse_menu_path
          expect(current_path).to eq(login_path)
          expect(page).to have_content('ログインしてください')
        end
      end

      context 'フルコースメニュー詳細ページにアクセス' do
        it 'アクセスに失敗する' do
          menu = create(:fullcourse_menu)
          visit fullcourse_menu_path(menu.id)
          expect(current_path).to eq(login_path)
          expect(page).to have_content('ログインしてください')
        end
      end

      context 'フルコースメニュー編集ページにアクセス' do
        it 'アクセスに失敗する' do
          create_list(:fullcourse_menu, 8, user_id: user.id)
          visit edit_fullcourse_menu_path(user.id)
          expect(current_path).to eq(login_path)
          expect(page).to have_content('ログインしてください')
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'フルコースメニュー作成' do
      context 'フォームの入力値が正常' do
        it 'フルコースメニュー作成が成功する' do
          create_menus
          expect(current_path).to eq(fullcourse_path(user.id))
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
      end

      context 'メニュー名が未入力で店名が入力済みの時' do
        it 'フルコースメニュー作成が失敗する' do
          visit new_fullcourse_menu_path
          fill_in 'name_0', with: 'tokyo'
          click_button '登録'
          expect(current_path).to eq('/fullcourse_menus')
          expect(page).to have_content('メニュー名を入力してください')
        end
      end
    end

    describe 'フルコースメニュー編集' do
      before { create_menus }
      context 'フォームの入力値が正常' do
        it 'フルコースメニュー編集が成功する', js: true do
          update_menus(user.id)
          expect(current_path).to eq(fullcourse_path(user.id))
          expect(page).to have_css('img.d-block.mx-auto.img-fluid')
          expect(page).to have_content('update_zensai')
          expect(page).to have_content('update_soup')
          expect(page).to have_content('update_fish')
          expect(page).to have_content('update_meat')
          expect(page).to have_content('update_main')
          expect(page).to have_content('update_salad')
          expect(page).to have_content('update_desert')
          expect(page).to have_content('update_drink')
        end
      end

      context 'メニュー名が未入力で店名が入力済みの時' do
        it 'フルコースメニュー編集が失敗する' do
          visit edit_fullcourse_menu_path(user.id)
          fill_in 'オードブル', with: ''
          click_button '登録'
          expect(current_path).to eq("/fullcourse_menus/#{user.id}")
          expect(page).to have_content('メニュー名を入力してください')
        end
      end

      context '他のユーザーのフルコースメニュー編集ページにアクセス' do
        it '編集ページへのアクセスに失敗する' do
          visit edit_fullcourse_menu_path(another_user.id)
          expect(current_path).to eq(fullcourses_path)
        end
      end
    end
  end
end
