
#ran into this error: Error: httpd24-tools conflicts with httpd-tools-2.2.31-1.6.amzn1.x86_64
#This is fix for that
execute 'remove_httpd_tools_24' do
  command 'yum remove httpd-tools-2.2.25-1.0.amzn1.x86_64'
end

include_recipe "apache2"
#include_recipe "apache2::mod_php5" 

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

apache_config 'faxer_vhost' do
  enable true
  source 'faxer_vhost.conf.erb'
end