require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { build(:post, user: user) }

  describe 'バリデーション' do
    it 'タイトルが空の場合は無効であること' do
      post.title = nil
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("を入力してください")
    end

    it 'コンテンツが空の場合は無効であること' do
      post.content = nil
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("を入力してください")
    end

    it 'タイトルが255文字を超える場合は無効であること' do
      post.title = 'a' * 256
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("は255文字以内で入力してください")
    end

    it 'コンテンツが65,535文字を超える場合は無効であること' do
      post.content = 'a' * 65_536
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("は65535文字以内で入力してください")
    end
  end
end
