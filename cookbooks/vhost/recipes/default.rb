#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#package "apti" 
case node['app']['webserver']
  when "apache"
	case node['app']['technology']
	  when "php"
		include_recipe "apache_php"
  	
	  when "ror"
		include_recipe "apache_ror"
  	end
end
