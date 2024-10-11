require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { build(:comment, user: user, post: post) }

  describe 'バリデーション' do
    it '内容が空の場合は無効であること' do
      comment.content = nil
      expect(comment).not_to be_valid
    end

    it '内容が65,535文字を超える場合は無効であること' do
      comment.content = 'a' * 65_536
      expect(comment).not_to be_valid
    end

    it '内容が適切な場合は有効であること' do
      comment.content = 'これはテストコメントです。'
      expect(comment).to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'userとの関連があること' do
      expect(comment).to respond_to(:user)
    end

    it 'postとの関連があること' do
      expect(comment).to respond_to(:post)
    end

    it 'notificationsとの関連があること' do
      expect(comment).to respond_to(:notifications)
    end
  end
end
