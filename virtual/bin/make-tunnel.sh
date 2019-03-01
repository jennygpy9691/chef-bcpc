#!/bin/bash

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

set -xe

root_dir=$(git rev-parse --show-toplevel)

virtual_dir="${root_dir}/virtual"

bootstrap_name="r1n0"

os_name=`uname -s`
if [[ $os_name =~ Darwin ]]; then
    host_ip=`ipconfig getifaddr en0`
else
    host_ip=`hostname -i`
fi

cd $virtual_dir

CONFFILE="/tmp/ssh-config.$$"
vagrant ssh-config ${bootstrap_name} > $CONFFILE

myvip=`echo "sudo -u operations -i -- sh -c 'knife node show --long r1n1.bcpc.example.com'" | ssh -F ${CONFFILE} r1n0 | grep -i vip | awk '{print $2}'`

if [[ -n "${myvip}" ]]; then

    echo "*************************************************************"
    echo "Starting SSH tunnel from ${host_ip} to ${myvip}"
    echo "*************************************************************"

    sudo ssh -C -F ${CONFFILE} \
	 -L ${host_ip}:8443:${myvip}:443 \
	 -L ${host_ip}:2080:${myvip}:6080 \
	 ${bootstrap_name}
else
    echo "$0: Error VIP not found"
fi
