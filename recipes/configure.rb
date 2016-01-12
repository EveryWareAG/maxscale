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
end
