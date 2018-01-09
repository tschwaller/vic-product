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
Documentation  Test 2-05 - Configuration 1 VC6.5 ESX6.5 VIC OVA Secured SelfSigned
Resource  ../../resources/Util.robot
#Suite Setup  19-5-Setup-OVA-Harbor-Secured-SelfSigned
#Suite Teardown  19-5-Teardown-OVA-Harbor-Secured-SelfSigned

*** Variables ***
${developer}  test-user-developer
${guest}  test-user-guest
${password}  harbor-admin-passwd
${newPassword}  Test-new-password-1
${project}  vic-harbor
${image}  busybox
${container_name}  busy
${tag}  new
${developerRole}  Developer
${guestRole}  Guest
${developerEmail}  developer@test.com
${developerEmail2}  develope2@test.com
${guestEmail}  guest@test.com
${developerFullName}  Vic Developer
${guestFullName}  Vic Guest
${comments}  comments
${developer2}  test-user-developer2

*** Keywords ***
19-5-Setup-OVA-Harbor-Secured-SelfSigned
    ${esx1}  ${esx2}  ${esx3}  ${vc}  ${esx1-ip}  ${esx2-ip}  ${esx3-ip}  ${vc_ip}=  Create a Simple VC Cluster
    Set Global Variable  @{list}  ${esx1}  ${esx2}  ${esx3}  ${vc}

    Log To Console  Deploy VIC to the VC cluster
    Set Environment Variable  TEST_URL_ARRAY  ${vc}
    Set Environment Variable  TEST_USERNAME  Administrator@vsphere.local
    Set Environment Variable  TEST_PASSWORD  Admin\!23
    Set Environment Variable  BRIDGE_NETWORK  bridge
    Set Environment Variable  PUBLIC_NETWORK  vm-network
    Set Environment Variable  TEST_RESOURCE  /ha-datacenter/host/cls/Resources
    Set Environment Variable  TEST_DATACENTER  /ha-datacenter
    Set Environment Variable  TEST_DATASTORE  datastore1
    Set Environment Variable  TEST_TIMEOUT  30m
    
    Deploy VIC-OVA To Test Server  protocol=https
    Create Project And Three Users For It  developer=${developer}  developer2=${developer2}  developerEmail=${developerEmail}  developerEmail2=${developerEmail2}  developerFullName=${developerFullName}  password=${password}  userPassword=${newPassword}  comments=${comments}  guest=${guest}  developerRole=${developerRole}  guestRole=${guestRole}  project=${project}  public=${False}
    Install Harbor Self Signed Cert
    Install VIC Appliance To Test Server  vol=default --registry-ca=/etc/docker/certs.d/%{HARBOR_IP}/ca.crt  certs=${False} 
    Remove Environment Variable  DOCKER_HOST

19-5-Teardown-OVA-Harbor-Secured-SelfSigned
    Run Keyword And Continue On Failure  Cleanup VIC Appliance On Test Server
    ${out}=  Run Keyword And Continue On Failure  Run  govc vm.destroy 19-1-harbor
    Run Keyword And Continue On Failure  Nimbus Cleanup  ${list}  ${true}  ${true}

*** Test Cases ***
Test Pos001 Admin Operations
    Pass Execution  Test no longer valid
    Basic Docker Command With Harbor  user=admin  password=${password}  project=${project}  image=${image}  container_name=${container_name}
