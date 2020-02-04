# frozen_string_literal: true

name             'global'
maintainer       'Yusuke Murata'
maintainer_email 'info@muratayusuke.com'
license 'Apache 2.0'
description      'Installs/Configures global'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'
%w[mac_os_x ubuntu].each do |os|
  supports os
end
