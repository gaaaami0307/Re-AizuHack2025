#!/bin/bash

set -e  # エラーがあったらそこで止まる

echo "依存関係インストール"
sudo apt update
sudo apt install -y git build-essential libssl-dev libreadline-dev zlib1g-dev \
    mysql-server default-libmysqlclient-dev libyaml-dev

# rbenv インストール
if [ ! -d "$HOME/.rbenv" ]; then
  echo "rbenv をインストールします"
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init - bash)"

  # ruby-build インストール
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

# bashrc 反映（新規ターミナルでも使えるように）
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"

# Ruby インストール（必要に応じてバージョンを変更）
RUBY_VERSION=3.2.3
if ! rbenv versions | grep -q $RUBY_VERSION; then
  echo "Ruby $RUBY_VERSION をインストールします"
  rbenv install $RUBY_VERSION
fi

rbenv global $RUBY_VERSION

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"

rbenv rehash

# rails インストール
gem install rails
# bundler インストール
gem install bundler
rbenv rehash

# bundle install
bundle install

echo "データベース作成"
sudo service mysql start


echo "以下を行ってください。"
echo "sudo mysql"
echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
echo "FLUSH PRIVILEGES;"
echo "EXIT;"
echo " "
echo " "

echo "その後、\"新しい\"ターミナルにて、./start.shを実行してください。"
