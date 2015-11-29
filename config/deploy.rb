lock '3.4.0'

set :rvm_type, :user
set :rvm_ruby_version, '2.2.3'
set :rvm_roles, :all

set :application, 'zyvie'
set :repo_url, 'https://github.com/cosmosloth/zyvie.git'

ask :branch, 'master'

set :scm, :git

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

set :unicorn_config_path, -> { "#{fetch(:deploy_to)}/current/config/unicorn.rb" }

set :linked_files, %w{config/database.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle}

set :keep_releases, 5

namespace :deploy do

 desc 'Configure nginx files'
 task :configure_nginx do
   on roles(:web), in: :sequence, wait: 2 do
     execute "sudo cp #{current_path}/nginx/#{fetch(:application)}_#{fetch(:stage)}.conf /etc/nginx/sites-enabled/ && sudo /etc/init.d/nginx reload"
   end
 end

 desc 'Restart application'
 task :restart do
   on roles(:app), in: :sequence, wait: 5 do
   end
 end

 after :publishing, :configure_nginx

 after :publishing, :restart

 after :restart, :clear_cache do
   on roles(:web), in: :groups, limit: 3, wait: 2 do
   end
 end

end
