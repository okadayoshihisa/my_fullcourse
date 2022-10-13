require 'rails_helper'

RSpec.describe Store, type: :model do
  it '店名、住所、緯度、軽度、TELの組み合わせが重複している時登録できないこと' do
    store = create(:store)
    duplicated_store = build(:store, name: store.name, address: store.address)
    expect(duplicated_store).to be_invalid
    expect(duplicated_store.errors[:name]).to eq ['はすでに存在します']
  end

  it '店名、住所、緯度、軽度、TELの組み合わせが異なる時登録できること' do
    store = create(:store)
    build(:store)
    expect(store).to be_valid
  end
end
