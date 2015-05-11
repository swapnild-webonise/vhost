default['app']['server_name'] = "example.com"
default['app']['doc_root']="/var/www/#{node['app']['server_name']}"

default['app']['webserver']="apache"
default['packages']['php']['generic']=['php5','php5-mcrypt','php5-cgi','php5-cli','php5-common','php5-fpm','php5-gd','php5-mysql','imagemagick','php5-imagick','phpmyadmin','curl','libcurl3','libcurl3-dev','php5-curl','php-pear','php5-dev']

default['packages']['apache']['generic']=['apache2']
default['packages']['apache']['modules']=['headers']


#################################
#	apache_ror::ror.rb	#
#################################
default['passenger']['version']     = '4.0.56'
default['ruby']['version']='2.0.0'

case node['ruby']['version']
when '2.0.0'
        default['ruby']['link']='http://ftp.ruby-lang.org/pub/ruby/ruby-2.0.0-p643.tar.gz'
end

case node['ruby']['version']
when '2.1.0'
        default['ruby']['link']='http://ftp.ruby-lang.org/pub/ruby/ruby-2.1.0.tar.gz'
end

case node['ruby']['version']
when '2.1.4'
        default['ruby']['link']='http://ftp.ruby-lang.org/pub/ruby/ruby-2.1.4.tar.gz'
end

case node['ruby']['version']
when '2.1.5'
        default['ruby']['link']='http://ftp.ruby-lang.org/pub/ruby/ruby-2.1.5.tar.gz'
end

case node['ruby']['version']
when '1.9.3'
        default['ruby']['link']='http://ftp.ruby-lang.org/pub/ruby/ruby-1.9.3-p551.tar.gz'
end
##########################################################################################
