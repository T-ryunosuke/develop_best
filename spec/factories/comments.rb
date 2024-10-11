FactoryBot.define do
  factory :comment do
    content { "サンプルコメント" }
    association :user  # コメントを作成するユーザー
    association :post  # コメントが紐づく投稿
  end
end
