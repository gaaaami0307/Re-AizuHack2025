#!/bin/bash

set -e  # エラーがあったらそこで止まる
echo " "
echo " "
echo "うまく立ち上がらない場合以下を行ってください。"
echo "sudo mysql"
echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
echo "FLUSH PRIVILEGES;"
echo "EXIT;"
echo " "
echo " "

sudo service mysql start
echo "データベース作成"
rails db:create
rails db:migrate
echo "Railsサーバー起動"
rails server -b 0.0.0.0 -p 3000
