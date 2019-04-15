###############################################################################
# consul
###############################################################################

default['bcpc']['consul']['remote_file'] = {
  'file' => 'consul_1.4.0_linux_amd64.zip',
  'checksum' => '41f8c3d63a18ef4e51372522c1e052618cdfcffa3d9f02dba0b50820e8279824',
}

default['bcpc']['consul']['executable'] = '/usr/local/sbin/consul'
default['bcpc']['consul']['conf_dir'] = '/etc/consul/conf.d'
default['bcpc']['consul']['config']['datacenter'] = node.chef_environment
default['bcpc']['consul']['config']['client_addr'] = '127.0.0.1'
default['bcpc']['consul']['config']['advertise_addr'] = node['service_ip']
default['bcpc']['consul']['config']['data_dir'] = '/var/lib/consul'
default['bcpc']['consul']['config']['disable_update_check'] = true
default['bcpc']['consul']['config']['enable_script_checks'] = true
default['bcpc']['consul']['config']['server'] = true
default['bcpc']['consul']['config']['log_level'] = 'INFO'
default['bcpc']['consul']['config']['node_name'] = node['hostname']
default['bcpc']['consul']['config']['addresses']['dns'] = node['bcpc']['cloud']['vip']
default['bcpc']['consul']['config']['ports']['dns'] = 8600
default['bcpc']['consul']['config']['recursors'] = [node['bcpc']['cloud']['vip']]

# Service definitions reference:
# https://www.consul.io/docs/agent/services.html
default['bcpc']['consul']['services'] = [
  {
    'name' => 'mysql',
    'port' => 3306,
    'enable_tag_override' => true,
    'tags' => ['mysql'],
    'check' => {
      'name' => 'mysql',
      'args' => ['/usr/local/bcpc/bin/mysql-check'],
      'interval' => '10s',
      'timeout' => '2s',
    },
  },
  {
    'name' => 'haproxy',
    'check' => {
      'name' => 'haproxy',
      'args' => ['/usr/local/bcpc/bin/haproxy-check'],
      'interval' => '10s',
      'timeout' => '2s',
    },
  },
  {
    'name' => 'dns',
    'check' => {
      'name' => 'dns',
      'args' => ['/usr/local/bcpc/bin/dns-check'],
      'interval' => '10s',
      'timeout' => '2s',
    },
  },
]

# Watch definitions reference:
# https://www.consul.io/docs/agent/watches.html
default['bcpc']['consul']['watches'] = [
  {
    'service' => 'haproxy',
    'type' => 'checks',
    'args' => ['/usr/local/bcpc/bin/haproxy-watch'],
  },
  {
    'service' => 'mysql',
    'type' => 'checks',
    'args' => ['/usr/local/bcpc/bin/mysql-elect-watch'],
  },
  {
    'service' => 'mysql',
    'type' => 'checks',
    'args' => ['/usr/local/bcpc/bin/mysql-watch'],
  },
  {
    'service' => 'dns',
    'type' => 'checks',
    'args' => ['/usr/local/bcpc/bin/dns-watch'],
  },
]
