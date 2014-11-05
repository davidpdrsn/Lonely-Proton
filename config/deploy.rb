# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'lonely_proton'
set :repo_url, 'git@github.com:davidpdrsn/Lonely-Proton.git'
set :deploy_to, "/home/deployer/apps/#{fetch :application}"
set :pty, true
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :rbenv_type, :user
set :rbenv_ruby, '2.1.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

namespace :deploy do
  desc 'Precompile assets'
  task :compile_assets do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{current_path} && bundle exec rake RAILS_ENV=#{fetch :stage} assets:precompile --trace"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "touch #{fetch :deploy_to}/shared/tmp/restart.txt"
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end
end
