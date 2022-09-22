require 'rails_helper'

RSpec.describe User, type: :model do
  it '名前、パスワード、メールアドレスが入力されていれば登録されること' do
    user = build(:user)
    expect(user).to be_valid
    expect(user.errors).to be_blank
  end
  it '名前が空の時登録できないこと' do
    user_without_name = build(:user, name: nil)
    expect(user_without_name).to be_invalid
    expect(user_without_name.errors[:name]).to eq ['を入力してください']
  end
  it 'メールアドレスが空の時登録できないこと' do
    user_without_email = build(:user, email: nil)
    expect(user_without_email).to be_invalid
    expect(user_without_email.errors[:email]).to eq ['を入力してください']
  end
  it 'パスワードが空の時登録できないこと' do
    user_without_password = build(:user, password: nil)
    expect(user_without_password).to be_invalid
    expect(user_without_password.errors[:password]).to eq ['は3文字以上で入力してください']
  end
  it 'メールアドレスが重複している時登録できないこと' do
    user = create(:user)
    another_user = build(:user, email: user.email)
    expect(another_user).to be_invalid
    expect(another_user.errors[:email]).to eq ['はすでに存在します']
  end
end
