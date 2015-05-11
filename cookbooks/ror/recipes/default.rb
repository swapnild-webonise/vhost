#
# Cookbook Name:: example
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# This Recipe is used for installing and configuring ruby 1.9.3 and its virtual hosts
#
case node[:platform]
when "ubuntu","debian"
#execute "apt-get-update" do
#  command "apt-get update"
#  action :run
#end

  %w{gcc libyaml-dev libxml2-dev libxslt1-dev zlib1g-dev build-essential openssl libssl-dev libmysqlclient-dev libreadline6-dev libcurl4-openssl-dev apache2-prefork-dev libapr1-dev libaprutil1-dev nodejs imagemagick}.each do |pkg|
  package pkg do
    action :install
  end
end

script "install_rails" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
        #Install ruby  from source file
        cd /usr/src
        wget #{node['ruby']['link']}
        tar -xzf ruby-*
        cd ruby-* && ./configure --prefix=/usr/local --enable-shared --disable-install-doc --with-opt-dir=/usr/local/lib &&  make && make install
  EOH
end

when "centos","rhel","redhat"

script "install_rails" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
  sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
  yum -y groupinstall "Development Tools"
  EOH
end

%w{libyaml libyaml-devel readline-devel ncurses-devel gdbm-devel tcl-devel openssl-devel db4-devel libffi-devel libxml2-devel libxslt-devel mysql-libs nodejs httpd-devel apr-devel apr-util-devel libcurl-devel ImageMagick ImageMagick-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

script "install_rails" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  cd /usr/src
  wget #{node['ruby']['link']}
  tar -xzf ruby-*
  cd ruby-* && ./configure --prefix=/usr/local --enable-shared --disable-install-doc --with-opt-dir=/usr/local/lib &&  make && make install
  EOH
end
end

gem_package "passenger" do
        version node['passenger']['version']
        action :install
end




execute "passenger_module" do
  command "passenger-install-apache2-module"
end

template "/etc/apache2/conf.d/passenger.conf" do
    source "passenger.conf.erb"
    owner "root"
    group "root"
    variables(:passenger_version => node['passenger']['version'], :ruby_version => node['ruby']['version'])
end

