require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
# 自動デプロイ時にこれらの内容が実行されます。