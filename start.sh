#!/bin/bash

set -e  # エラーがあったらそこで止まる

echo "Railsサーバー起動"
rails server -b 0.0.0.0 -p 3000
