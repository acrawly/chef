#
# Cookbook Name:: faxer
# Recipe:: default
#
# Copyright (c) 2016 Andrew Crawford, All Rights Reserved.

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

file '/etc/httpd/conf.d/faxer.conf' do
  content '
 <VirtualHost *:80>
  ServerAdmin support@crawford.works
  ServerName faxer.co
  ServerAlias www.faxer.co
  DocumentRoot /faxer

  LogLevel Warn
  ErrorLog /faxer/apache_logs/error.log
  CustomLog Combined /faxer/apache_logs/custom.log


  <Directory /faxer>
    Options +FollowSymLinks +Indexes
    AllowOverride none 
  </Directory>
</VirtualHost>'
  mode '0644'
  owner 'root'
  group 'root'
end

file '/faxer/index.php' do
  content '<?php phpinfo() ?>'
  mode '0755'
  owner 'apache'
  group 'apache'
end