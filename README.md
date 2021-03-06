# chef-bcpc

chef-bcpc is a set of [Chef](https://github.com/opscode/chef) cookbooks that
build a highly-available [OpenStack](http://www.openstack.org/) cloud.

The cloud consists of head nodes (OpenStack controller services, Ceph Mons,
etc.) and work nodes (hypervisors).

Each head node runs all of the core services in a highly-available manner. Each
work node runs the relevant services (nova-compute, Ceph OSDs, etc.).


## Getting Started

The following instructions will get chef-bcpc up and running on your local
machine for development and testing purposes.

See the [Hardware Deployment][Hardware Deployment] section for notes on how to
deploy the chef-bcpc on hardware.


### Prerequisites

* OS X or Linux
* CPU that supports VT-x virtualization extensions
* 16 GB of memory
* 100 GB of free disk space
* Vagrant 2.1+
* VirtualBox 5.2+
* git, curl, rsync, ssh, jq, make, ansible


### Local Build

* Review `virtual/topology/topology.yml` for the topology you will build and
make changes as required, e.g. assign more or less RAM based on your topology
and your build environment. Other topologies exist in the same directory.
* If a proxy server is required for internet access, set the variables TBD
* If additional CA certificates are required (e.g. for a proxy), set the variables TBD
* From the root of the chef-bcpc git repository run the following command:

```shell
make create all
```


## Hardware Deployment

TBD


## Contributing

Currently, most development is done by a team at Bloomberg L.P. but we would
like to build a community around this project. PRs and issues are welcomed. If
you are interested in joining the team at Bloomberg L.P. please see available
opportunities at the [Bloomberg L.P. careers site](https://careers.bloomberg.com/job/search?qf=cloud).


## License

This project is licensed under the Apache 2.0 License - see the
[LICENSE.txt](LICENSE.txt) file for details.


## Built With

chef-bcpc is built with the following open source software:

 - [Ansible](https://www.ansible.com/)
 - [Apache HTTP Server](http://httpd.apache.org/)
 - [Ceph](http://ceph.com/)
 - [Chef](http://www.opscode.com/chef/)
 - [HAProxy](http://haproxy.1wt.eu/)
 - [Memcached](http://memcached.org)
 - [OpenStack](http://www.openstack.org/)
 - [Percona XtraDB Cluster](http://www.percona.com/software/percona-xtradb-cluster)
 - [PowerDNS](https://www.powerdns.com/)
 - [RabbitMQ](http://www.rabbitmq.com/)
 - [Ubuntu](http://www.ubuntu.com/)
 - [Vagrant](http://www.vagrantup.com/)
 - [VirtualBox](https://www.virtualbox.org/)

Thanks to all of these communities for producing this software!
