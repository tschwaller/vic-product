Test 5-01 - Multiple Datacenter
=======

# Purpose:
To verify the VIC OVA product works when the vCenter appliance has multiple datacenters

# References:
[1 - VMware vCenter Server Availability Guide](http://www.vmware.com/files/pdf/techpaper/vmware-vcenter-server-availability-guide.pdf)

# Environment:
This test requires access to VMware Nimbus cluster for dynamic ESXi and vCenter creation

# Test Steps:
1. Deploy a new vCenter with 3 different datacenters and a mix of ESX within the datacenters
2. Install the VIC OVA product into one of the datacenters
3. Walk through completing the install and use the VCH creation wizard to create a VCH
4. Run a variety of docker commands on the VCH appliance

# Expected Outcome:
The VCH appliance should deploy without error and each of the docker commands executed against it should return without error

# Possible Problems:
None
