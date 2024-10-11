require 'rails_helper'

RSpec.describe Category, type: :model do
  it '有効なカテゴリを作成できること' do
    category = build(:category)
    expect(category).to be_valid
  end
end
