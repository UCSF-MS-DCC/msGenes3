# config valid for current version and patch releases of Capistrano
lock "~> 3.18.1"


server '169.230.177.100', port: 22, roles: [:web, :app, :db], primary: true
set :repo_url,        'https://github.com/UCSF-MS-DCC/msGenes3.git'
#set :repo_url,        'ssh://git@github.com:UCSF-MS-DCC/msGenes3.git'
set :application,     'ms_genes'
set :user,            'deployment'
set :git_http_username, 'urrik98'
set :environment_variables, { 'RUBY_VERSION' => '2.5.1' }

set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
#set :deploy_via,      :remote_cache
set :deploy_to,       "/var/www/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/msgenes-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), auth_methods: ['publickey'], keys: %w(/Users/arenschen/.ssh/msgenes_deploy) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :console_user, :msgenes
#set :ruby_version, '2.5.1'
## Defaults:
# set :scm,           :git
set :branch,        :main
# set :format,        :pretty
set :log_level,     :debug
set :keep_releases, 5
set :linked_files, %w(config/master.key)
## Linked Files & Directories (Default None):
#set :linked_files, %w{config/database.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Check if agent forwarding is working"
  task :forwarding do
    on roles(:all) do |h|
      if test("env | grep SSH_AUTH_SOCK")
        info "Agent forwarding is up to #{h}"
      else
        error "Agent forwarding is NOT up to #{h}"
      end
    end
  end
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/main`
        puts "WARNING: HEAD is not the same as origin/main"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after "deploy", "print_env_vars" do
    puts "GEM_PATH: #{ENV['GEM_PATH'].join(', ')}"
    puts "BUNDLE_GEMFILE: #{ENV['BUNDLE_GEMFILE']}"
  end

  # after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma