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

#    Install VIC Product OVA  bin/vic-*.ova
    Set Environment Variable  VIC_IP  10.160.222.203
    Log  %{VIC_IP}
    
    Open Browser  http://%{VIC_IP}
    Wait Until Page Contains Element  target
    Wait Until Page Contains Element  user
    Wait Until Page Contains Element  password
    Wait Until Page Contains Element  login-submit
    Input Text  target  %{TEST_URL}
    Input Text  user  %{TEST_USERNAME}
    Input Text  password  %{TEST_PASSWORD}
    Click Button  login-submit
    Wait Until Page Contains  Getting Started