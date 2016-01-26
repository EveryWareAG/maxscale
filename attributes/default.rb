# create /root/.maxadmin
default['maxscale']['root_maxadmin'] = true
# enable configuration via databag
default['maxscale']['databag']['enabled'] = false
# set databag name
default['maxscale']['databag']['name'] = 'maxscale'
# set databag item
default['maxscale']['databag']['item'] = 'config'
# set ulimit for max number of open files
default['maxscale']['default']['nofile'] = '65335'
# default base configuration
default['maxscale']['config'] = {
  maxscale: {
    threads: 1
  },
  CLI_listener: {
    type: 'listener',
    service: 'CLI',
    protocol: 'maxscaled',
    address: 'localhost',
    port: '6603'
  },
  CLI: {
    type: 'service',
    router: 'cli'
  }
}
