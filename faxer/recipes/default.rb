
include_recipe "apache2"
include_recipe "php::source"
include_recipe "apache2::mod_php5" 

service 'apache2' do
  action [:enable, :start]
end

#
# Set up the local application config.
# This part is most likely to be different for different applications.
#

directory '/var/www/html/faxer/apache_logs' do
  owner 'apache'
  group 'apache'
  mode '0755'
  action :create
  recursive true
end

file '/var/www/html/faxer/index.php' do
  content '<h1>Hello from Faxer</h1><br /><br /><?php phpinfo(); ?>'
  mode '0755'
  owner 'apache'
  group 'apache'
end

web_app "faxer.co" do
  template 'faxer_vhost.conf.erb'
  server_name 'faxer.co'
end

#apache_site 'faxer.co' do
# enable true
#end