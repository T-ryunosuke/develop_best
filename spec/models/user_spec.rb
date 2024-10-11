require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:category) { create(:category) }
  let(:post) { create(:post, user: user, category: category) } # userがpostのowner

  describe 'バリデーション' do
    it '名前が空の場合は無効であること' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it '名前の長さが25文字を超える場合は無効であること' do
      user.name = 'a' * 26
      expect(user).not_to be_valid
    end

    it 'メールが空の場合は無効であること' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'メールがユニークであること' do
      create(:user, email: 'test@example.com')
      user.email = 'test@example.com'
      expect(user).not_to be_valid
    end

    it 'パスワードが4文字未満の場合は無効であること' do
      user.password = '123'
      expect(user).not_to be_valid
    end

    it 'パスワード確認がない場合は無効であること' do
      user.password_confirmation = nil
      expect(user).not_to be_valid
    end

    it 'パスワードとパスワード確認が一致しない場合は無効であること' do
      user.password_confirmation = 'different'
      expect(user).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'postsとの関連があること' do
      expect(user).to respond_to(:posts)
    end

    it 'commentsとの関連があること' do
      expect(user).to respond_to(:comments)
    end

    it 'likesとの関連があること' do
      expect(user).to respond_to(:likes)
    end

    it 'liked_postsとの関連があること' do
      expect(user).to respond_to(:liked_posts)
    end

    it 'relationshipsとの関連があること' do
      expect(user).to respond_to(:relationships)
    end

    it 'reverse_of_relationshipsとの関連があること' do
      expect(user).to respond_to(:reverse_of_relationships)
    end

    it 'authenticationsとの関連があること' do
      expect(user).to respond_to(:authentications)
    end

    it 'active_notificationsとの関連があること' do
      expect(user).to respond_to(:active_notifications)
    end

    it 'passive_notificationsとの関連があること' do
      expect(user).to respond_to(:passive_notifications)
    end
  end

  describe 'インスタンスメソッド' do
    it '自分のオブジェクトかどうかを確認する' do
      # `post` は現在のユーザーが所有する投稿であるべき
      expect(user.mine?(post)).to be true
    end

    it '他のユーザーのオブジェクトの場合はfalseを返す' do
      other_user = create(:user) # 他のユーザーを作成
      expect(other_user.mine?(post)).to be false
    end
  end
end
