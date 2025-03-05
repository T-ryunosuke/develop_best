source "https://rubygems.org"

gem "rails", "~> 7.2.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# 導入
gem "pry-rails"
gem "rails-i18n", "~> 7.0.0"
gem "sorcery"
gem "kaminari"
gem "ransack", "~> 4.3"
gem "carrierwave", "2.2.2"
gem "enum_help"
gem "fog-aws", "~> 3.30"
gem "meta-tags", require: "meta_tags"
gem "mini_magick"
gem "dotenv-rails"
gem "redcarpet"
gem "config"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false

  # 導入
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"

  # 導入
  gem "webdrivers"
  gem "simplecov"
end
