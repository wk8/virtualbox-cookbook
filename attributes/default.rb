#
# Cookbook Name:: virtualbox
# Attributes:: default
#
# Copyright 2011, Joshua Timberman
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


default['virtualbox']['url'] = ''
default['virtualbox']['version'] = ''

case node['platform_family']
when 'mac_os_x'
  default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/4.2.8/VirtualBox-4.2.8-83876-OSX.dmg'
  default['virtualbox']['version'] = vbox_version(node['virtualbox']['url'])
when 'windows'
  default['virtualbox']['url'] = 'http://download.virtualbox.org/virtualbox/4.2.8/VirtualBox-4.2.8-83876-Win.exe'
  default['virtualbox']['version'] = vbox_version(node['virtualbox']['url'])
when 'debian', 'rhel'
  default['virtualbox']['version'] = '4.2'
end
