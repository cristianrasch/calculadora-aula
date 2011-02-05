# Customized deploy.rb
default_run_options[:pty] = true

set :application, "calculadora_aula"

set :repository,  "git@heroku.com:calculadora-aula.git"
set :scm, "git"
set :user, "cristian"
set :branch, "master"

#set :repository, "https://calculadoraaula.svn.sourceforge.net/svnroot/calculadoraaula/trunk"
#set :scm_username, 'cristianrasch'
#set :scm_password, proc{Capistrano::CLI.password_prompt('SVN pass:' )}

target_server = 'localhost'

role :web, target_server
role :app, target_server
role :db, target_server, :primary => true

set :user, "cristian"
#ssh_options[:port] = 2222

set :deploy_via, :remote_cache
#set :deploy_via, :export
set :deploy_to, "/home/#{user}/public_html/#{application}"

desc "Symlink the database config file from shared
      directory to current release directory."
task :symlink_database_yml do
  run "ln -nsf #{shared_path}/config/database.yml
       #{release_path}/config/database.yml"
end
after 'deploy:update_code', 'symlink_database_yml'

#desc "Symlink the app config file from shared
#      directory to current release directory."
#task :symlink_app_config_yml do
#  run "ln -nsf #{shared_path}/config/app_config.yml
#       #{release_path}/config/app_config.yml"
#end
#after 'deploy:update_code', 'symlink_app_config_yml'

#desc "Symlink the backgroundrb config file from shared
#      directory to current release directory."
#task :symlink_backgroundrb_config_yml do
#  run "ln -nsf #{shared_path}/config/backgroundrb.yml
#       #{release_path}/config/backgroundrb.yml"
#end
#after 'deploy:update_code' , 'symlink_backgroundrb_config_yml'

#after 'deploy:update_code', 'deploy:migrate'

after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"

namespace(:deploy) do
  desc "Restart app servers"
  task :restart do
    sudo "/etc/init.d/mongrel_cluster restart"
    #run "touch #{current_path}/tmp/restart.txt"
  end
end

#desc "Restart the mongrel cluster"
#task :restart_mongrel_cluster , :roles => :app do
#  run "/etc/init.d/mongrel_cluster restart"
#end

#desc "Restart the thin cluster"
#task :restart_thin_cluster , :roles => :app do
#  sudo "/etc/init.d/thin restart"
#end

namespace(:db) do
  desc "Resets production db"
  task :reset, :roles => :db do
    run "cd #{current_path} && rake RAILS_ENV=production db:migrate:reset"
  end
  
  desc "Populates production db"
  task :seed, :roles => :db do
    run "cd #{current_path} && rake RAILS_ENV=production db:seed"
  end
end

#desc "Stop the backgroundrb server"
#task :stop_backgroundrb , :roles => :app do
#  run "ruby #{current_path}/script/backgroundrb stop"
#end

#desc "Start the backgroundrb server"
#task :start_backgroundrb , :roles => :app do
#  run "ruby #{current_path}/script/backgroundrb start -e production > /dev/null 2>&1"
#end

#desc "Start the backgroundrb server"
#task :restart_backgroundrb, :roles => :app do
#  stop_backgroundrb
#  start_backgroundrb
#end

task :tail_log, :roles => :app do
  stream "tail -f #{shared_path}/log/production.log"
end

#Only the Contents of log and public/uploads Will Be Kept Between Deployments

#after 'deploy:update_code' , 'deploy:link_images'
#namespace(:deploy) do
#  task :link_images do
#    run <<-CMD
#      cd #{release_path} &&
#      ln -nfs #{shared_path}/uploads #{release_path}/public/uploads
#    CMD
#  end
#end
