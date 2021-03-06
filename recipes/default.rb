#
# Cookbook Name:: mysql-fabric
# Recipe:: default
#
# The MIT License (MIT)
# 
# Copyright (c) 2015 Hisashi kOMINE
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

include_recipe 'mysql56'

template '/etc/mysql/fabric-init.sql' do
  source 'fabric-init.sql.erb'
  mode   0600
  variables config: node['mysql-fabric']
  notifies :run, 'execute[fabric-init]', :immediately
end
execute 'fabric-init' do
  command 'mysql -u root < /etc/mysql/fabric-init.sql'
  action :nothing
end

template '/etc/mysql/fabric.cfg' do
  source 'fabric.cfg.erb'
  mode   0600
  variables config: node['mysql-fabric']
  notifies :run, 'execute[fabric-setup]', :immediately
end
execute 'fabric-setup' do
  command 'mysqlfabric manage setup'
  notifies :run, 'execute[fabric-restart]'
  action :nothing
end

execute 'fabric-restart' do
  command <<-EOC
    if mysqlfabric manage ping; then
      mysqlfabric manage stop
    fi
    mysqlfabric manage start --daemonize
  EOC
  action :nothing
end
