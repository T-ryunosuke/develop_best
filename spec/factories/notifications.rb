FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user   # 通知を送信するユーザー
    association :visited, factory: :user   # 通知を受信するユーザー
    association :post    # (オプション) 通知に関連する投稿
    association :comment   # (オプション) 通知に関連するコメント
    action { 'follow' }   # 通知のアクションタイプ
    checked { false }   # デフォルトで未確認
  end
end
