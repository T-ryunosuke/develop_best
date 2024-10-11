FactoryBot.define do
  factory :user do
    password { "passpass" }
    password_confirmation { "passpass" }
    sequence(:email) { |n| "rspec#{n}@gmail.com" } # 一意のメールアドレスを生成
    name { "RSpec" }
  end
end
