#
# Author:: Julian C. Dunn (<jdunn@chef.io>)
# Cookbook Name:: apache2_windows
# Resource:: virtualhost
#
# Copyright:: 2013, Chef Software, Inc.
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

actions :create, :delete

attribute :server_name, kind_of: String, name_attribute: true
attribute :server_aliases, kind_of: [Array, String]
attribute :server_port, kind_of: Integer, default: 80, required: true
attribute :docroot, kind_of: String, required: true
attribute :directory_options, kind_of: Array, default: ['FollowSymLinks']
attribute :allow_overrides, kind_of: Array, default: ['None']
attribute :loglevel, kind_of: String, equal_to: %w(emerg alert crit error warn notice info debug), default: 'info', required: true
attribute :directory_index, kind_of: [Array, String], default: 'index.html'
attribute :template_cookbook, kind_of: String, default: 'apache2_windows'
attribute :template_name, kind_of: String, default: 'virtualhost.conf.erb'

default_action :create
