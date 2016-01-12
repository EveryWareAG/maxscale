default['maxscale']['root_maxadmin'] = true
default['maxscale']['databag']['enabled'] = false
default['maxscale']['databag']['name'] = 'maxscale'
default['maxscale']['databag']['item'] = 'config'

default['maxscale']['config'] = {
  maxscale: {
    threads: 1,
    ms_timestamp: 0,
    log_messages: 1,
    log_trace: 0,
    log_debug: 0
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
