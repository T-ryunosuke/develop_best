FactoryBot.define do
  factory :post do
    title { "サンプル" }
    content { "サンプル" }
    association :user
    association :category
  end
end
