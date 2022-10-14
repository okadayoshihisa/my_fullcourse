require 'rails_helper'

RSpec.describe Word, type: :model do
  it 'すべて入力されており、nameとcategoryの組み合わせがユニークな時、登録できる' do
    create(:word)
    another_word = build(:word)
    expect(another_word).to be_valid
  end
  it 'nameが空の時、登録できない' do
    word = build(:word, name: nil)
    expect(word).to be_invalid
    expect(word.errors[:name]).to eq ['を入力してください']
  end
  it 'categoryが空の時、登録できない' do
    word = build(:word, category: nil)
    expect(word).to be_invalid
    expect(word.errors[:category]).to eq ['を入力してください']
  end
  it 'scoreが空の時、登録できない' do
    word = build(:word, score: nil)
    expect(word).to be_invalid
    expect(word.errors[:score]).to eq ['を入力してください']
  end
  it 'nameとcategoryの組み合わせが重複する時、登録できない' do
    word = create(:word)
    duplicated_word = build(:word, name: word.name, category: word.category)
    expect(duplicated_word).to be_invalid
    expect(duplicated_word.errors[:name]).to eq ['はすでに存在します']
  end
end
