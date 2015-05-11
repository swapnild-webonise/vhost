#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#package "apti" 

case node[:platform]
when "ubuntu","debian"
  node['packages']['php']['generic'].each do |pkg|
  package pkg do
    action :install
  end
  end
  node['packages']['apache']['generic'].each do |pkg|
  package pkg do
    action :install
   end
  end
when "centos","rhel","redhat"
  package "httpd" do
    action :install
  end
end

case node["platform"]
when "centos","redhat","fedora"
  service "httpd" do
    supports :restart => true, :reload => true, :start => true
    action [:enable, :start]
  end
when "ubuntu","debian"
  service "apache2" do
    supports :restart => true, :reload => true, :start => true
    action [:enable, :start]
  end
end

directory(node[:app][:doc_root]) do
	owner 'vagrant'
	group 'www-data'
	mode '0755'
	action :create
end

template "/etc/apache2/sites-available/#{node['app']['server_name']}.conf" do
	source "php_vhost.conf.erb"
		variables( :server_name => node['app']['server_name'], :doc_root => node['app']['doc_root'])
end


link "/etc/apache2/sites-enabled/#{node['app']['server_name']}.conf" do
	to "/etc/apache2/sites-available/#{node['app']['server_name']}.conf"
end


node['packages']['apache']['modules'].each do |mods|
	execute mods do
	  cwd "/etc/apache2/mods-available"
	  command "a2enmod #{mods}"
	end
end

service "apache2" do
	supports :restart => true, :reload => true, :start => true
	action [:enable, :restart]
end
