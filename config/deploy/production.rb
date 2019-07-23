
set :stage,     :production
set :rails_env, :production
set :branch,    :master

server "34.66.75.239", port: "22", user: "deployer", roles: [:web, :app, :db], primary: true

# Change these
set :repo_url,                "git@github.com:tanngoc93/demo-test.git"
set :user,                    "deployer"
set :application,             "demo-test"
set :deploy_to,               "/var/www/#{fetch(:application)}"

# Don"t change these unless you know what you"re doing
set :pty,                     false
set :use_sudo,                false
set :deploy_via,              :remote_cache

#
set :rvm_ruby_version,        "2.5.5"

#
set :passenger_restart_with_touch, true
set :passenger_in_gemfile, true

##
set :ssh_options,             { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }

##

## Linked Files & Directories (Default None):
set :linked_files,            %w{config/master.key config/database.yml}
set :linked_dirs,             %w{log tmp/pids tmp/cache tmp/sockets public/packs node_modules}

##
namespace :rakeman do
  task :invoke do
    on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "#{ENV["task"]}"
        end
      end
    end
  end
end
