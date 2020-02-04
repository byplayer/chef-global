# frozen_string_literal: true

configure_cmd = "./configure --prefix=#{node['global']['prefix']} --with-exuberant-ctags=#{`which ctags-exuberant`}"
if platform_family?('debian', 'ubuntu')
  pkgs = %w[libncurses5-dev exuberant-ctags]
  pkgs.each do |pkg|
    package pkg
  end
end

if platform_family?('mac_os_x')
  configure_cmd = "./configure --prefix=#{node['global']['prefix']} --with-exuberant-ctags=#{`which ctags`}"
end

remote_file "#{Chef::Config['file_cache_path']}/global-#{node['global']['version']}.tar.gz" do
  source    node['global']['url']
  mode      0o0644
  not_if "test -f #{Chef::Config['file_cache_path']}/global-#{node['global']['version']}.tar.gz"
end

execute "Extracting and Building Global #{node['global']['version']} from Source" do
  cwd Chef::Config['file_cache_path']
  command <<-COMMAND
    tar xzf global-#{node['global']['version']}.tar.gz
    cd global-#{node['global']['version']}
    ./configure --prefix=#{node['global']['prefix']} --with-exuberant-ctags=#{`which ctags-exuberant`}

    make
    make install
  COMMAND
  creates "#{node['global']['prefix']}/bin/global"
  not_if "#{node['global']['prefix']}/bin/global --version | grep #{node['global']['version']}"
end
