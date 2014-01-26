require 'capistrano-deploy'
use_recipes :git, :bundle, :rails, :unicorn, :rails_assets

set :default_environment, {
  'PATH'          => '/home/berlin/.rbenv/shims:/home/berlin/.rbenv/bin:$PATH',
  'RBENV_ROOT'    => '/home/berlin/.rbenv'
}

server '95.85.49.5', :web, :app, :db, :primary => true
set :user, 'berlin'
set :deploy_to, '/home/berlin/web-app'
set :repository, 'git@github.com:slonia/mysite.git'

after 'deploy:update', 'bundle:install'
after 'deploy:update', 'deploy:assets:precompile'
after 'deploy:restart', 'unicorn:stop'

