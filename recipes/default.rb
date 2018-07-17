pkgs = %w{libncurses5-dev exuberant-ctags}
pkgs.each do |pkg|
  package pkg
end

remote_file "#{Chef::Config['file_cache_path']}/global-#{node['global']['version']}.tar.gz" do
  source    "http://tamacom.com/global/global-#{node['global']['version']}.tar.gz"
  mode      00644
  not_if "test -f #{Chef::Config['file_cache_path']}/global-#{node['global']['version']}.tar.gz"
end

execute "Extracting and Building Global #{node['global']['version']} from Source" do
  cwd Chef::Config['file_cache_path']
  command <<-COMMAND
    tar xzf global-#{node['global']['version']}.tar.gz
    cd global-#{node['global']['version']}
    ./configure --prefix=#{node['global']['prefix']} --with-exuberant-ctags=#{`which ctags-exuberant`} #{node['global']['configure_opt']}

    make
    make install
  COMMAND
  not_if "#{node['global']['prefix']}/bin/global --version | grep #{node['global']['version']}"
end
