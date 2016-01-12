# maxscale Cookbook [![Build Status](https://travis-ci.org/EveryWare/maxscale.svg?branch=master)](https://travis-ci.org/EveryWare/maxscale)

This cookbook installs and configure maxscale

## Requirements

### Supported OS

The following 64-bit platforms are supported:

* Ubuntu 14.04 LTS


### Dependencies

* [apt](https://supermarket.getchef.com/cookbooks/apt) Chef LWRP Cookbook


## Attributes

| attribute                                | Type      | Default    | description                              |
|:-----------------------------------------|:---------:|:----------:|:-----------------------------------------|
| `node['maxscale']['databag']['enabled']` | `Boolen`  | `false`    | Enable Data Bag support                  |
| `node['maxscale']['databag']['name']`    | `String`  | `maxscale` | Data Bag name                            |
| `node['maxscale']['databag']['item']`    | `String`  | `config`   | Data Bag item name                       |
| `node['maxscale']['config']`             | `Hash`    | `{}`       | Maxscale config                          |

## Usage

The `node['maxscale']['config']` attribute should look like:

```
default['maxscale']['config'] = {
  maxscale: {
    threads: 4,
    ms_timestamp: 1,
    log_messages: 1,
    log_trace: 1,
    log_debug: 1
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
  },
  debug_listener: {
    type: 'listener',
    service: 'debug',
    protocol: 'telnetd',
    port: 4442
  },
  debug: {
    type: 'service',
    router: 'debugcli',
    router_options: 'user'
  },
  db1: {
    type: 'server',
    address: '10.0.0.1',
    port: 3306,
    protocol: 'MySQLBackend'
  },
  db2: {
    type: 'server',
    address: '10.0.0.2',
    port: 3306,
    protocol: 'MySQLBackend'
  },
  db3: {
    type: 'server',
    address: '10.0.0.3',
    port: 3306,
    protocol: 'MySQLBackend'
  },
  db4: {
    type: 'server',
    address: '10.0.0.4',
    port: 3306,
    protocol: 'MySQLBackend'
  },
  db5: {
    type: 'server',
    address: '10.0.0.5',
    port: 3306,
    protocol: 'MySQLBackend'
  }
}
```

### Data Bag support is also available.

As .merge is used using a databag in addition is possible as well:

```
{
  "id": "config",
  "config": {
    "galera_monitor": {
      "type": "monitor",
      "module": "galeramon",
      "servers": "db1,db2,db3,db4,db5",
      "user": "maxscalemon",
      "passwd": "4C1E57AB442F995FE330E1B68D6299F5D436EB09E4715011A32665CE378D8B1B810B73F1C0F291A85A45E55E9F4C6A66",
      "monitor_interval": "2000",
      "disable_master_failback": "1",
      "available_when_donor": "1",
      "disable_master_role_setting": "0"
    },
    "galera_rr_service": {
      "type": "service",
      "router": "readconnroute",
      "#connection_timeout": "300",
      "router_options": "synced",
      "servers": "db1,db2,db3,db4,db5",
      "user": "maxscaleroute",
      "passwd": "59DFB08A63C42CB302B8DFE1B57F5BD0A4B410A2F97FA0776ABB8ABBE5A8F436FA8FE21CF5479013C2E53E66931EC631",
      "enable_root_user": "0"
    },
    "galera_rw_service": {
      "type": "service",
      "router": "readwritesplit",
      "#connection_timeout": "300",
      "router_options": "slave_selection_criteria=LEAST_CURRENT_OPERATIONS",
      "max_slave_connections": "100%",
      "servers": "db1,db2,db3,db4,db5",
      "user": "maxscaleroute",
      "passwd": "59DFB08A63C42CB302B8DFE1B57F5BD0A4B410A2F97FA0776ABB8ABBE5A8F436FA8FE21CF5479013C2E53E66931EC631",
      "enable_root_user": "0"
    },
    "galera_rr_listener": {
      "type": "listener",
      "service": "galera_rr_service",
      "protocol": "MySQLClient",
      "address": "10.0.0.201",
      "port": "3306"
    },
    "galera_rw_listener": {
      "type": "listener",
      "service": "galera_rw_service",
      "protocol": "MySQLClient",
      "address": "10.0.0.202",
      "port": "3306"
    }
  }
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Copyright 2016, EveryWare

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
