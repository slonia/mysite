require 'capistrano-deploy'
use_recipes :git, :bundle, :rails, :unicorn

server '95.85.49.5', :web, :app, :db, :primary => true
set :user, 'berlin'
set :deploy_to, '/home/berlin/web-app'
set :repository, 'git@github.com:slonia/mysite.git'

after 'deploy:update', 'bundle:install'
after 'deploy:restart', 'unicorn:stop'

