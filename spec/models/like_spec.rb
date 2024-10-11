require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:like) { build(:like, user: user, post: post) }

  describe 'バリデーション' do
    it '有効ないいねが作成できること' do
      expect(like).to be_valid
    end

    it '同じユーザーが同じ投稿に対していいねできないこと' do
      like.save
      duplicate_like = build(:like, user: user, post: post)
      expect(duplicate_like).not_to be_valid
    end
  end
end
