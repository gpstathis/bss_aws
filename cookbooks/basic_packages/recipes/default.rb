execute "update" do 
  user "root"
  command "apt-get update"
end

package "git-core" do
  action :install
end

package "htop" do
  action :install
end

package "nmap" do
  action :install
end

package "sysv-rc" do
  action :install
end

package "sysstat" do
  action :install
end

package "munin" do
  action :install
end

package "unzip" do
  action :install
end
