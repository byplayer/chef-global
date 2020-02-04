# frozen_string_literal: true

default['global']['version'] = '6.6.4'
default['global']['url'] = "http://tamacom.com/global/global-#{node['global']['version']}.tar.gz"
default['global']['prefix'] = '/opt/global'
default['global']['configure_opt'] = ''
