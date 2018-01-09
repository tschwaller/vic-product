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
Documentation  Test 2-04 - Configuration 4 ESX 6.0 VIC Harbor Secured Self Signed
Resource  ../../resources/Util.robot
#Suite Setup  19-4-Setup
#Suite Teardown  19-4-Teardown

*** Variables ***
${developer}  test-user-developer
${guest}  test-user-guest
${password}  Test-password-1
${newPassword}  Test-new-password-1
${project}  vic-harbor
${image}  busybox
${container_name}  busy
${tag}  new
${developerRole}  Developer
${guestRole}  Guest
${developerEmail}  developer@test.com
${developerEmail2}  developer2@test.com
${guestEmail}  guest@test.com
${developerFullName}  Vic Developer
${guestFullName}  Vic Guest
${comments}  comments
${developer2}  test-user-developer2

*** Keywords ***
19-4-Setup
    Set Environment Variable  ESX_VERSION  3620759
    ${esx1}  ${esx1-ip}=  Deploy Nimbus ESXi Server  %{NIMBUS_USER}  %{NIMBUS_PASSWORD}
    Set Environment Variable  TEST_URL_ARRAY  ${esx1-ip}
    Set Environment Variable  TEST_USERNAME  root
    Set Environment Variable  TEST_PASSWORD  e2eFunctionalTest
    Set Environment Variable  BRIDGE_NETWORK  VM Network
    Set Environment Variable  PUBLIC_NETWORK  "VM Network"
    Set Environment Variable  TEST_DATACENTER  ${EMPTY}
    Set Environment Variable  TEST_RESOURCE  ${EMPTY}
    Set Environment Variable  TEST_TIMEOUT  30m
    
    Set Suite Variable  ${ESX1}  ${esx1}
    Set Suite Variable  ${ESX1-IP}  ${esx1-ip}
    Set Global Variable  @{list}  ${esx1}

    Install Harbor To Test Server  name=19-4-harbor  protocol=https
    Log To Console  Harbor installer completed successfully...
    
    Install Harbor Self Signed Cert
    Install VIC Appliance To Test Server  vol=default --registry-ca=/etc/docker/certs.d/%{HARBOR_IP}/ca.crt  certs=${false}
    Create Project And Three Users For It  developer=${developer}  developer2=${developer2}  developerEmail=${developerEmail}  developerEmail2=${developerEmail2}  developerFullName=${developerFullName}  password=${password}  comments=${comments}  guest=${guest}  developerRole=${developerRole}  guestRole=${guestRole}  project=${project}  public=${False}
    Remove Environment Variable  DOCKER_HOST

19-4-Teardown
    Run Keyword And Continue On Failure  Cleanup VIC Appliance On Test Server
    ${out}=  Run Keyword And Continue On Failure  Run  govc vm.destroy 19-4-harbor
    Run Keyword And Continue On Failure  Nimbus Cleanup  ${list}

*** Test Cases ***
Test Pos001 Admin Operations
    Pass Execution  Test no longer valid
    Basic Docker Command With Harbor  user=admin  password=%{TEST_PASSWORD}  project=${project}  image=${image}  container_name=${container_name}
