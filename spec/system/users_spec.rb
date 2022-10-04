require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザー新規登録' do
    before do
      visit root_path
      click_link('新規登録')
    end
    context 'フォームの入力値が正常' do
      it 'ユーザーの新規作成が成功する' do
        fill_in 'ユーザー名', with: 'test_name'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'test_password'
        fill_in 'パスワード確認', with: 'test_password'
        click_button('登録')
        expect(current_path).to eq(login_path)
        expect(page).to have_content('ユーザーを登録しました')
      end
    end
    context 'ユーザー名が未入力' do
      it 'ユーザーの新規作成が失敗する' do
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'test_password'
        fill_in 'パスワード確認', with: 'test_password'
        click_button('登録')
        expect(current_path).to eq('/users')
        expect(page).to have_content('ユーザー登録に失敗しました')
      end
    end
    context 'メールアドレスが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        fill_in 'ユーザー名', with: 'test_name'
        fill_in 'パスワード', with: 'test_password'
        fill_in 'パスワード確認', with: 'test_password'
        click_button('登録')
        expect(current_path).to eq('/users')
        expect(page).to have_content('ユーザー登録に失敗しました')
      end
    end
    context '登録済のメールアドレスを使用' do
      it 'ユーザーの新規作成が失敗する' do
        user = create(:user)
        fill_in 'ユーザー名', with: 'test_name'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'test_password'
        fill_in 'パスワード確認', with: 'test_password'
        click_button('登録')
        expect(current_path).to eq('/users')
        expect(page).to have_content('ユーザー登録に失敗しました')
      end
    end
  end
end
