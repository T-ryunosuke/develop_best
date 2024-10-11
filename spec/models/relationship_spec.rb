require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:follower) { create(:user) }
  let(:followee) { create(:user) }
  let(:relationship) { build(:relationship, follower: follower, followee: followee) }

  describe 'バリデーション' do
    it '有効なフォロワーとフォロイーがある場合は有効であること' do
      expect(relationship).to be_valid
    end

    it 'フォロワーが存在しない場合は無効であること' do
      relationship.follower = nil
      expect(relationship).not_to be_valid
    end

    it 'フォロイーが存在しない場合は無効であること' do
      relationship.followee = nil
      expect(relationship).not_to be_valid
    end
  end

  describe 'アソシエーション' do
    it 'followerとの関連があること' do
      expect(relationship).to respond_to(:follower)
    end

    it 'followeeとの関連があること' do
      expect(relationship).to respond_to(:followee)
    end
  end
end
