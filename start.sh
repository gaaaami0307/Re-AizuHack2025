#!/bin/bash

set -e  # エラーがあったらそこで止まる

echo "依存関係インストール"
sudo apt update
sudo apt install ruby-full
sudo apt install mysql-server
sudo gem install bundler
sudo apt-get update
sudo apt-get install -y default-libmysqlclient-dev build-essential
sudo apt-get install -y libyaml-dev


sudo bundle install
#yarn install

echo "データベース作成"
sudo service mysql start
rails db:create
rails db:migrate

echo "完了"
