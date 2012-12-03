include_recipe "apt"
include_recipe "apache2"
include_recipe "passenger_apache2"

# Globals
deploy_dir="/opt/bss_aws"
curr_env="development"

# Remove the default apache site
execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

# Create the app directory
directory "#{deploy_dir}" do
  recursive true
  mode "0755"
  action :create
end

# Create the shared data directory
directory "#{deploy_dir}/shared" do
  mode "0755"
  action :create
end

# Create the db directory
directory "#{deploy_dir}/shared/db" do
  mode "0755"
  owner "nobody"
  group "nogroup"
  action :create
end

# Copy over the shared db config file
cookbook_file "#{deploy_dir}/shared/database.yml" do
  source "database.yml"
  mode "0755"
end

# Use https://github.com/opscode-cookbooks/application_ruby and 
# http://wiki.opscode.com/display/chef/Deploy+Resource#DeployResource-DeployResource
# to configure the app; application_ruby utilizes heavily deploy/deploy_revision
application "#{deploy_dir}" do
  path "#{deploy_dir}"
  environment "RAILS_ENV" => "#{curr_env}"
  environment_name "#{curr_env}"
  repository "git://github.com/gpstathis/rolodecks.git"
  revision "HEAD"
  enable_submodules true
  migrate true
  
  rails do 
    gems ['bundler']
    bundler_deployment true
    database do
      adapter "sqlite3"
      database "#{deploy_dir}/shared/db/#{curr_env}.sqlite3"
    end
  end
  
  before_symlink do
    execute "rake db:seed" do
      command "bundle exec rake db:seed"
      user "root"
      cwd "#{release_path}"
    end
    
    directory "#{release_path}/tmp" do
      recursive true
      mode "0755"
      owner "nobody"
      group "nogroup"
      action :create
    end
    
    execute "chmod db permissions" do
      command "chown nobody #{deploy_dir}/shared/db/#{curr_env}.sqlite3"
    end
  end
  
end

# Use https://github.com/opscode-cookbooks/apache2 and 
# https://github.com/opscode-cookbooks/passenger_apache2
# to configure and restart apache2
web_app "bss_aws" do
  docroot "/opt/bss_aws/current/public"
  server_name `curl http://instance-data.ec2.internal/latest/meta-data/public-hostname`
  rails_env "#{curr_env}"
end
