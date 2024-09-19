FROM ruby:3.2.3
ARG UID=1000
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
ENV BUNDLE_APP_CONFIG /myapp/.bundle
RUN apt-get update -qq \
  && apt-get install -y ca-certificates curl gnupg \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && NODE_MAJOR=20 \
  && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn vim imagemagick
RUN useradd -m -u $UID rails
RUN mkdir /myapp
WORKDIR /myapp
# GemfileとGemfile.lockのコピーとbundle install
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . /myapp

# アプリケーションのオーナーを設定
RUN chown rails:rails -R /myapp

# アセットのプリコンパイル
RUN rails assets:precompile

# コンテナ起動時のコマンド
CMD ["bash", "-c", "bundle exec rails server -b 0.0.0.0"]
