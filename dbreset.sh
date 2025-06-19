#!/bin/bash

set -e  # エラーがあったらそこで止まる

rails db:reset
rails db:seed
