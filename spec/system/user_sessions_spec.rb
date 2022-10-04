require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }
  describe 'ログイン前' do
    context 'フォームの入力値が正常な時' do
      it 'ログインできること' do
        login(user)
        expect(current_path).to eq(fullcourses_path)
        expect(page).to have_content('ログインしました')
      end
    end
    context 'フォームが未入力の時' do
      it 'ログインが失敗すること' do
        visit login_path
        click_button('ログイン')
        expect(page).to have_content('ログインに失敗しました')
      end
    end
  end
  describe 'ログイン後' do
    context 'ログアウトボタンをクリックした時' do
      it 'ログアウトが成功すること' do
        login(user)
        click_link('dropdownUser1')
        click_link('ログアウト')
        expect(page).to have_content('ログアウトしました')
        expect(current_path).to eq(login_path)
      end
    end
  end
end
