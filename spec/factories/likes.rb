FactoryBot.define do
  factory :like do
    association :user  # いいねをするユーザー
    association :post  # いいねが紐づく投稿
  end
end
