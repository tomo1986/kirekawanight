# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'bisyoujo_zukan_night'
set :repo_url, 'ssh://git@github.com/tomo1986/kirekawanight.git'
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, "2.3.1"
set :releases, 5
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :deploy_tag, "deploy-#{Time.now.strftime('%Y%m%d-%H%M-%S')}"



# set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system}
set :delayed_job_server_role, :delayed_job
after 'deploy:publishing'


namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

