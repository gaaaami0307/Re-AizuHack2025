#!/bin/bash

set -e  # エラーがあったらそこで止まる
echo "データベース作成"
rails db:create
rails db:migrate
echo "Railsサーバー起動"
rails server -b 0.0.0.0 -p 3000
