require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:visitor) { create(:user) }
  let(:visited) { create(:user) }
  let(:post) { create(:post) }
  let(:notification) { build(:notification, visitor: visitor, visited: visited, post: post) }

  describe 'バリデーション' do
    it '有効な通知が作成できること' do
      expect(notification).to be_valid
    end

    it 'visitor_idがない場合は無効であること' do
      notification.visitor_id = nil
      expect(notification).not_to be_valid
    end

    it 'visited_idがない場合は無効であること' do
      notification.visited_id = nil
      expect(notification).not_to be_valid
    end

    it 'actionがない場合は無効であること' do
      notification.action = nil
      expect(notification).not_to be_valid
    end
  end
end
