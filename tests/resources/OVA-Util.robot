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
Documentation  This resource provides any keywords related to VIC Product OVA

*** Keywords ***
Get Most Recent VIC Product OVA Release
    ${output}=  Run  gsutil ls -l gs://vic-product-ova-releases/vic-* | grep -v TOTAL | sort -k2 -r | head -n1 | xargs | cut -d ' ' -f 3 | cut -d '/' -f 4
    [Return]  ${output}

Install VIC Product OVA
    [Arguments]  ${ova-file}  ${datastore}=%{TEST_DATASTORE}  ${name}=%{VIC_NAME}  ${root_pwd}=e2eFunctionalTest  ${network}=%{PUBLIC_NETWORK}
    ${output}=  Run  ovftool --datastore=${datastore} --noSSLVerify --acceptAllEulas --name=${name} --diskMode=thin --powerOn --X:waitForIp --X:injectOvfEnv --X:enableHiddenProperties --prop:appliance.root_pwd='${root_pwd}' --prop:appliance.permit_root_login=True --net:"Network"="${network}" ${ova-file} 'vi://%{TEST_USERNAME}:%{TEST_PASSWORD}@%{TEST_URL}%{TEST_RESOURCE}'
    Should Contain  ${output}  Completed successfully
    Should Contain  ${output}  Received IP address:
    
    ${output}=  Split To Lines  ${output} 
    :FOR  ${line}  IN  @{output}
    \   ${status}=  Run Keyword And Return Status  Should Contain  ${line}  Received IP address:
    \   ${ip}=  Run Keyword If  ${status}  Fetch From Right  ${line}  ${SPACE}
    \   Run Keyword If  ${status}  Set Environment Variable  VIC_IP  ${ip}
    \   Return From Keyword If  ${status}  ${ip}
