# Copyright 2018 VMware, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License

*** Settings ***
Documentation  Test 5-02 - OVA Upgrade
Resource  ../../resources/Util.robot
Suite Setup  Wait Until Keyword Succeeds  10x  10m  OVA Upgrade Setup
Suite Teardown  Close All Browsers

*** Variables ***
${esx_number}=  3
${datacenter}=  ha-datacenter

${busybox-docker-image-name}  registry.hub.docker.com/library/busybox
${busybox-docker-image-tag}  latest
${sample-command-exit}  ls
${cp-card-status-stopped}  STOPPED

*** Keywords ***
OVA Upgrade Setup
    [Timeout]    110 minutes
    Run Keyword And Ignore Error  Nimbus Cleanup  ${list}  ${false}
    Log To Console  \nStart downloading vic-v1.2.1-4104e5f9.ova...
    ${pid1}=  Start Process  wget -nc https://storage.googleapis.com/vic-product-ova-releases/vic-v1.2.1-4104e5f9.ova  shell=True
    ${latest-ova}=  Run  gsutil ls -l gs://vic-product-ova-builds/ | grep -v TOTAL | sort -k2r | (head -n1 ; dd of=/dev/null 2>&1 /dev/null) | xargs | cut -d ' ' -f 3 | cut -d '/' -f 4
    Log To Console  \nStart downloading ${latest-ova}...
    ${pid2}=  Start Process  wget -nc https://storage.googleapis.com/vic-product-ova-builds/${latest-ova}  shell=True
    
    ${esx1}  ${esx2}  ${esx3}  ${vc}  ${esx1-ip}  ${esx2-ip}  ${esx3-ip}  ${vc-ip}=  Create a Simple VC Cluster
    Log To Console  Finished Creating Cluster ${vc}
    Set Suite Variable  @{list}  ${esx1}  ${esx2}  ${esx3}  %{NIMBUS_USER}-${vc}

    Set Environment Variable  TEST_URL  ${vc-ip}
    Set Environment Variable  TEST_USERNAME  Administrator@vsphere.local
    Set Environment Variable  TEST_PASSWORD  Admin\!23
    Set Environment Variable  BRIDGE_NETWORK  bridge
    Set Environment Variable  PUBLIC_NETWORK  vm-network
    Set Environment Variable  TEST_RESOURCE  /ha-datacenter/host/cls
    Set Environment Variable  TEST_TIMEOUT  30m
    Set Environment Variable  TEST_DATASTORE  datastore1

    ${ret}=  Wait For Process  ${pid1}
    ${ret}=  Wait For Process  ${pid2}

    Set Browser Variables
    Open Firefox Browser

Install And Initialize OVA
    [Arguments]  ${ova-file}  ${ova-name}
    Log To Console  Installing 1.2.1 ova, enrolling psc, and checking online component status...
    Install Common OVA If Not Already  ${ova-file}  ${ova-name}
    # validate complete installation on UI
    Log To Console  Initializing the OVA using the getting started ui...
    Log In And Complete OVA Installation
    # verify all services restarted after ui initialization
    Log To Console  Checking for online final component status...
    Wait for Online Components  %{OVA_IP}

*** Test Cases ***
Test
    Log To Console  \nStarting test...
    Set Environment Variable  OVA_NAME  OVA-5-02-TEST
    Set Global Variable  ${OVA_USERNAME_ROOT}  root
    Set Global Variable  ${OVA_PASSWORD_ROOT}  e2eFunctionalTest


    Install And Initialize OVA  vic-v1.2.1-4104e5f9.ova  %{OVA_NAME}
    
    Download VIC Engine If Not Already
    ${vch-name}=  Install VCH  certs=${false}
    Add New Container Host And Verify Card  ${vch-name}
    Navigate To Containers Page
    Select Containers Page Iframe
    Verify Containers Page
    Provision And Verify New Container  ${busybox-docker-image-name}  ${busybox-docker-image-tag}  ${sample-command-exit}  ${cp-card-status-stopped}
    Unselect Containers Page Iframe

    # preserve previous ova details
    Set Global Variable  ${OLD_OVA_IP}  %{OVA_IP}
    Set Global Variable  ${OLD_OVA_NAME}  %{OVA_NAME}

    Set Environment Variable  OVA_NAME  OVA-5-02-TEST-LATEST
    Install And Initialize OVA  ${latest-ova}  %{OVA_NAME}
    
    # upgrade ova
    # verify existing vch host and container

    