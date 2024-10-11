class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"

  # 1. フォロー関係が重複しないことを保証する
  validates :follower_id, uniqueness: { scope: :followee_id }
end
