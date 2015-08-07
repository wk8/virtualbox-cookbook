#
# Cookbook Name:: virtualbox
# Recipe:: default
#
# Copyright 2011-2013, Joshua Timberman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'mac_os_x'

  sha256sum = vbox_sha256sum(node['virtualbox']['url'])

  # starting from version 4.1.22, Oracle started packaging the Mac OS dmg
  # as pkg, as opposed to mpkg before
  dmg_package_type = if Gem::Version.new(node['virtualbox']['version']) > Gem::Version.new('4.1.20')
    'pkg'
  else
    'mkpg'
  end

  dmg_package 'VirtualBox' do
    source node['virtualbox']['url']
    checksum sha256sum
    type dmg_package_type
  end

when 'windows'

  sha256sum = vbox_sha256sum(node['virtualbox']['url'])
  win_pkg_version = node['virtualbox']['version']
  Chef::Log.debug("Inspecting windows package version: #{win_pkg_version.inspect}")

  windows_package "Oracle VM VirtualBox #{win_pkg_version}" do
    action :install
    source node['virtualbox']['url']
    checksum sha256sum
    installer_type :custom
    options "-s"
  end

when 'debian'

  apt_repository 'oracle-virtualbox' do
    uri 'http://download.virtualbox.org/virtualbox/debian'
    key 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc'
    distribution node['lsb']['codename']
    components ['contrib']
  end

  package "virtualbox-#{node['virtualbox']['version']}"
  package 'dkms'

when 'rhel'

  yum_repository 'oracle-virtualbox' do
    description 'Oracle Linux / RHEL / CentOS-$releasever / $basearch - VirtualBox'
    url 'http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch'
    gpgkey 'https://www.virtualbox.org/download/oracle_vbox.asc'
    action :create
  end

  package "VirtualBox-#{node['virtualbox']['version']}"
end
