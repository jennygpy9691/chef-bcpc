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

vagrant ssh-config ${bootstrap_name} > /tmp/ssh-config.$$

sudo ssh -C -F /tmp/ssh-config.$$ \
     -L ${host_ip}:8443:10.10.254.254:443 \
     -L ${host_ip}:2080:10.10.254.254:6080 \
     ${bootstrap_name}
