
#ran into this error: Error: httpd24-tools conflicts with httpd-tools-2.2.31-1.6.amzn1.x86_64
#This is fix for that
execute 'remove_httpd_tools_24' do
  command 'yum remove httpd-tools-2.2.25-1.0.amzn1.x86_64'
end

default['faxer']['hostname'] = 'faxer.co'

include_recipe "apache2"
#include_recipe "apache2::mod_php5" 

service 'apache2' do
  action [:enable, :start]
end

#
# Set up the local application config.
# This part is most likely to be different for different applications.
#
directory '/faxer' do
  owner 'apache'
  group 'apache'
  mode '0755'
  action :create
end

directory '/faxer/apache_logs' do
  owner 'apache'
  group 'apache'
  mode '0755'
  action :create
end

file '/faxer/index.php' do
  content '<?php phpinfo() ?>'
  mode '0755'
  owner 'apache'
  group 'apache'
end

web_app "faxer.co" do
  template 'faxer_vhost.conf.erb'
  server_name 'faxer.co'
end

apache_config 'faxer.co' do
  enable true
end