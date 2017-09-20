# Copyright 2017 VMware, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

*** Settings ***
Documentation  Test 1-01 - Smoke Test
Resource  ../../resources/Util.robot
Test Timeout  20 minutes

*** Test Cases ***
Smoke Test
    Set Environment Variable  TEST_USERNAME  administrator@vsphere.local
    Set Environment Variable  TEST_PASSWORD  Admin!23
    Set Environment Variable  TEST_URL  10.160.207.246
    Set Environment Variable  TEST_RESOURCE  /vcqaDC/host/cls
    Set Environment Variable  TEST_DATASTORE  vsanDatastore
    Set Environment Variable  PUBLIC_NETWORK  vm-network
    Set Environment Variable  VIC_NAME  VIC-mike2

    Install VIC Product OVA  bin/vic-*.ova

    Log  %{VIC_IP}
    #curl -k --write-out '\n%{http_code}\n' --header "Content-Type: application/json" -X POST --data  '{"target":"10.160.207.246:443","user":"administrator@vsphere.local","password":"Admin!23"}' https://10.160.202.65:9443/register