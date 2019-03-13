#!/bin/bash -ex

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

root_dir=$(git rev-parse --show-toplevel)
virtual_dir="${root_dir}/virtual"
bootstrap="r1n0"

cd ${virtual_dir}

CONFFILE="/tmp/ssh-config.$$"
vagrant ssh-config ${bootstrap_name} > ${CONFFILE}

vip=`echo "sudo -u operations -i -- sh -c 'knife node show --long r1n1.bcpc.example.com'" | ssh -F ${CONFFILE} r1n0 | grep -i vip | awk '{print $2}'`

if [[ -n "${vip}" ]]; then

    echo "*************************************************************"
    echo "Starting SSH tunnel to ${vip}"
    echo "*************************************************************"

    ssh -C -F ${CONFFILE} \
        -L 127.0.0.1:8443:${vip}:443 \
        -L 127.0.0.1:2080:${vip}:6080 \
        ${bootstrap}

    echo "Horizon available at:"
    echo "https://127.0.0.1:8443/horizon/"
else
    echo "${0}: Error VIP not found"
fi
