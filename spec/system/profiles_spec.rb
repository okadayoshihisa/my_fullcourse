require 'rails_helper'

RSpec.fdescribe "Profiles", type: :system do
  describe 'ログイン後' do
    let(:user) { create(:user) }
    before do
      login(user)
      visit profile_path
    end
    describe 'プロフィール編集' do
      before { click_link('プロフィール編集') }
      context 'フォームの入力値が正常' do
        it 'プロフィールを更新できる' do
          fill_in 'メールアドレス', with: 'test_email@example.com'
          fill_in 'ユーザー名', with: 'test_name'
          click_button('更新')
          expect(current_path).to eq(profile_path)
          expect(page).to have_content('ユーザーを更新しました')
        end
      end
      context 'ユーザー名が未入力' do
        it 'プロフィール更新が失敗する' do
          fill_in 'ユーザー名', with: ''
          click_button('更新')
          expect(current_path).to eq('/profile')
          expect(page).to have_content('ユーザーを更新できませんでした')
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          fill_in 'メールアドレス', with: ''
          click_button('更新')
          expect(current_path).to eq('/profile')
          expect(page).to have_content('ユーザーを更新できませんでした')
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          another_user = create(:user)
          fill_in 'メールアドレス', with: another_user.email
          click_button('更新')
          expect(current_path).to eq('/profile')
          expect(page).to have_content('ユーザーを更新できませんでした')
        end
      end
    end
  end
  describe 'ログイン前' do
    it 'プロフィールページにアクセスできない' do
      visit profile_path
      expect(current_path).to eq(login_path)
      expect(page).to have_content('ログインしてください')
    end
  end
end
