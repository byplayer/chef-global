# frozen_string_literal: true

default['global']['version'] = '6.6.13'
default['global']['url'] = "https://ftp.gnu.org/pub/gnu/global/global-#{node['global']['version']}.tar.gz"
default['global']['prefix'] = '/opt/global'
