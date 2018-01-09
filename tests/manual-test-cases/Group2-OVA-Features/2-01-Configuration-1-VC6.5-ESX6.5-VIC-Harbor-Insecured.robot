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
Documentation  Test 2-01 - Configuration 1 VC6.5 ESX6.5 VIC Harbor Insecured
Resource  ../../resources/Util.robot
#Suite Setup  19-1-Setup
#Suite Teardown  19-1-Teardown

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
${developerEmail2}  develope2@test.com
${guestEmail}  guest@test.com
${developerFullName}  Vic Developer
${guestFullName}  Vic Guest
${comments}  comments
${developer2}  test-user-developer2

*** Keywords ***
19-1-Setup
    ${esx1}  ${esx2}  ${esx3}  ${vc}  ${esx1-ip}  ${esx2-ip}  ${esx3-ip}  ${vc_ip}=  Create a Simple VC Cluster
    Set Global Variable  @{list}  ${esx1}  ${esx2}  ${esx3}  ${vc}
    Install Harbor To Test Server  name=19-1-harbor
    Restart Docker With Insecure Registry Option
    Install VIC Appliance To Test Server  vol=default --insecure-registry %{HARBOR_IP}  certs=${False}
    Create Project And Three Users For It  developer=${developer}  developer2=${developer2}  developerEmail=${developerEmail}  developerEmail2=${developerEmail2}  developerFullName=${developerFullName}  password=${password}  comments=${comments}  guest=${guest}  developerRole=${developerRole}  guestRole=${guestRole}  project=${project}  public=${False}
    Remove Environment Variable  DOCKER_HOST

19-1-Teardown
    Run Keyword And Continue On Failure  Cleanup VIC Appliance On Test Server
    ${out}=  Run Keyword And Continue On Failure  Run  govc vm.destroy 19-1-harbor
    Run Keyword And Continue On Failure  Nimbus Cleanup  ${list}

*** Test Cases ***
Test Pos001 Admin Operations
    Pass Execution  Test no longer valid
    Basic Docker Command With Harbor  user=admin  password=%{TEST_PASSWORD}  project=${project}  image=${image}  container_name=${container_name}
