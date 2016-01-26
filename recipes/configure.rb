if node['maxscale']['databag']['enabled']
  # Load config from Data Bag
  databag_config = data_bag_item(node['maxscale']['databag']['name'], \
                                 node['maxscale']['databag']['item'])
  config_all = node['maxscale']['config'].merge(databag_config['config'])
else
  config_all = node['maxscale']['config']
end

template '/etc/maxscale.cnf' do
  source 'maxscale.cnf.erb'
  action :create
  notifies :reload, 'service[maxscale]', :delayed
  variables(
    config: config_all
  )
  sensitive true
end

ruby_block 'ensure /etc/default/maxscale is supported' do
  block do
    fe = Chef::Util::FileEdit.new('/etc/init.d/maxscale')
    fe.insert_line_after_match( \
      %r{/usr/bin/maxscale.*\|\|.*exit.*\$_RETVAL_NOT_INSTALLED}, \
      "\n# Source additional command line arguments. \
 (added by Chef)\n[ -f /etc/default/maxscale ] && \
 . /etc/default/maxscale")
    fe.write_file
  end
  notifies :restart, 'service[maxscale]', :delayed
  not_if 'grep "/etc/default/maxscale" /etc/init.d/maxscale'
end

template '/etc/default/maxscale' do
  source 'default.maxscale.erb'
  action :create
  notifies :restart, 'service[maxscale]', :delayed
end
