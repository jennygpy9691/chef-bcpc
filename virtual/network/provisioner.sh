#!/bin/bash -x

# Copyright 2019, Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

is_tor() {
    [[ ${1} =~ ^tor ]]
}

is_spine() {
    [[ ${1} =~ ^spine || ${1} =~ ^network ]]
}

switch_config() {
    # enable ipv4 forwarding
    sudo sed -i 's/#\(net.ipv4.ip_forward\)/\1/g' /etc/sysctl.d/99-sysctl.conf
    sudo sysctl -q -p /etc/sysctl.d/99-sysctl.conf

    if is_spine "${1}" ; then
        # add masquerading source NAT rule on spines
        sudo iptables -A POSTROUTING -j MASQUERADE -o eth0 -t nat
        sudo iptables-save | sudo tee /etc/iptables/rules.v4
    fi

    # configure BIRD
    sudo cp "/vagrant/bird/${1}.conf" /etc/bird/bird.conf
    sudo systemctl restart bird
}

base_config() {
    for s in rpcbind lxcfs snapd lxd iscsid ; do
        sudo systemctl stop ${s}
        sudo systemctl disable ${s}
    done
    if is_tor "${1}" ; then
        sudo dhclient -x
    fi
    sudo cp "/vagrant/netplan/${1}.yaml" /etc/netplan/01-netcfg.yaml
    sudo netplan apply
    sudo systemctl restart lldpd
}

package_installation() {
    dpkg --remove-architecture i386
    apt="sudo DEBIAN_FRONTEND=noninteractive apt-get -y"
    ${apt} update
    ${apt} install lldpd traceroute bird iptables-persistent
}

package_installation
base_config "${1}"
switch_config "${1}"
