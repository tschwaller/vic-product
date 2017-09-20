Test 1-01 - Smoke Test
=======

# Purpose:
To verify that VIC product installs and appears to be functioning properly

# References:
[1 - VIC Product Documentation](https://vmware.github.io/vic-product/assets/files/html/1.2/index.html)

# Environment:
This test requires that a vSphere server is running and available

# Test Steps:
1. Login to target vCenter
2. Virtual Machines -> Deploy OVF Template - Click through install, providing root password
3. Power on VM
4. Show power on screen console
5. Open http://<appliance_ip> in browser
6. Browser should redirect to https://<appliance_ip>:9443
7. Perform appliance initialization
8. In browser, enter vSphere credentials at https://<appliance_ip>:9443
9. By CLI:  
`curl -k --write-out '%{http_code}' --header "Content-Type: application/json" -X POST --data '{"target":"'"${VCENTER_TARGET}"'","user":"'"${VCENTER_USERNAME}"'","password":"'"${VCENTER_PASSWORD}"'"}' https://<appliance_ip>:9443/register)`
10. Should receive 200 upon success
11. Download the VIC Engine bundle
12. In browser, click the link on the Getting Started Page
13. In browser, got to https://<appliance_ip>:9443/files
14. Extract the files
15. Create a VCH:  
`./vic-machine-linux create -t <vCenter_ip> -u administrator@vsphere.local -p 'Admin!23' --image-store vsanDatastore --bridge-network bridge --public-network vm-network --registry-ca ca.crt --no-tlsverify`
16. VCH will be tested in later steps

# Expected Outcome:
* All steps should be successful

# Possible Problems:
None





