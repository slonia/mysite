require 'capistrano-deploy'

use_recipes :git, :bundle, :rails, :unicorn, :rails_assets, :whenever

SIDEKIQ_LOCKS  = ['deploy', 'deploy:migrate', 'deploy:update',
                 'deploy:migrations']

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
after 'deploy:restart', 'whenever:update_crontab'

on :start,  'sidekiq:down', :only => SIDEKIQ_LOCKS
on :finish, 'sidekiq:up',   :only => SIDEKIQ_LOCKS

namespace :sidekiq do
  [:up, :down, :status]. each do |action|
    desc 'Performs sv #{action.to_s} on sidekiq'
    task action do
      run "for task in /etc/service/*sidekiq*; do sv #{action.to_s} ${task##/*/} || true; done"
    end
  end

  desc 'Restarts sidekiq'
  task :restart do; down; sleep 5; up; end
end
