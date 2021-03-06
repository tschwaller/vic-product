# vSphere Admins

<!-- USE THIS SUMMARY FILE FOR PDF GENERATION ONLY -->

* [Install, Deploy, Maintain Infrastructure](README.md)
 * [Installation](installing_vic.md)
     * [Download Installer](download_vic.md) 
     * [Deployment Prerequisites](vic_installation_prereqs.md)
     * [Deploy the Appliance](deploy_vic_appliance.md)
     * [Download the vSphere Integrated Containers Engine Bundle](vic_engine_bundle.md)
     * [Installing the Plug-ins](install_vic_plugin.md)
         * [vCenter Server for Windows](plugins_vc_windows.md)
         * [vCenter Server Appliance](plugins_vcsa.md)
  * [Deploy VCHs](deploy_vch.md)
     * [Using vic-machine](using_vicmachine.md)
         * [Running Commands](running_vicmachine_cmds.md)
         * [Obtain Certificate Thumbprints](obtain_thumbprint.md)
         * [Set Environment Variables](vic_env_variables.md)
         * [Open the Required Ports on ESXi Hosts](open_ports_on_hosts.md)
         * [Deploy a VCH to an ESXi Host with No vCenter Server](deploy_vch_esxi.md)
         * [Deploy a VCH to a Basic vCenter Server Cluster](deploy_vch_vcenter.md)
         * [Verify the Deployment of a VCH](verify_vch_deployment.md)
         * [VCH Boot Options](vch_boot_options.md)
     * [Deploy VCHs in vSphere Client](deploy_vch_client.md)
     * [General Settings](vch_general_settings.md)
     * [Compute Capacity](vch_compute.md)
     * [Storage Capacity](vch_storage.md)
         * [Image Datastore](image_store.md)
         * [Volume Datastores](volume_stores.md)
     * [Networks](vch_networking.md)
         * [Bridge Networks](bridge_network.md)
         * [Public Network](public_network.md)
         * [Client Network](client_network.md)
         * [Management Network](mgmt_network.md)
         * [Proxy Servers](vch_proxy.md)
         * [Container Networks](container_networks.md)
     * [Security](vch_security.md)
         * [VCH Certificate Options](vch_cert_options.md)
         * [Disable Client Verification](tls_unrestricted.md)
         * [Registry Access](vch_registry.md) 
     * [Operations User](set_up_ops_user.md)
         * [Manually Create a User Account for the Operations User](ops_user_manual.md) 
     * [Finish VCH Deployment](complete_vch_deployment_client.md)
     * [Deploy VCH for dch-photon](deploy_vch_dchphoton.md)
  * [VCH Administration](vch_admin.md)
     * [Interoperability](interop.md)
     * [VCH Admin in the vSphere Client](vch_admin_client.md)
         * [View All VCH and Container Information](access_h5_ui.md)
         * [View Individual VCH and Container Information](vch_portlet_ui.md)
     * [VCH Admin with vic-machine](vch_admin_vicmachine.md)
         * [Obtain Version Information](vic_machine_version.md)
         * [Common Options](common_vic_options.md)
         * [List VCHs](list_vch.md)
         * [Obtain General VCH Information and Connection Details](inspect_vch.md)
         * [Obtain VCH Configuration Information](inspect_vch_config.md)
         * [Configure Running VCHs](configure_vch.md)
         * [Debug Running VCHs](debug_vch.md)
             * [Enable Shell Access](vch_shell_access.md)
             * [Authorize SSH Access](vch_ssh_access.md) 
     * [Delete VCHs](remove_vch.md)
     * [VCH Admin Portal](access_vicadmin.md)
         * [Browser-Based Certificate Login](browser_login.md)
         * [Command Line Certificate Login](cmdline_login.md)
         * [VCH Admin Status Reference](vicadmin_status_ref.md)
  * [Upgrading](upgrading_vic.md) 
     * [Pre-Upgrade Tasks](pre_upgrade_tasks.md)
     * [Upgrade the Appliance](upgrade_appliance.md)
     * [Upgrade VCHs](upgrade_vch.md)
         * [VCH Upgrade Options](upgrade_vch_options.md)
     * [Upgrade Plug-In on Windows](upgrade_h5_plugin_windows.md)
     * [Upgrade Plug-In VCSA](upgrade_h5_plugin_vcsa.md)
  * [Managing the Appliance](manage_appliance.md)
     * [Reconfigure the Appliance](reconfigure_appliance.md)
     * [Reinitialize the Appliance](reinitialize_appliance.md)
         * [Re-Tag the Appliance](retag_appliance.md)
     * [Check Service Status](service_status.md)
     * [Restart Services](restart_services.md)  
  * [Backup and Restore](backup_vic.md)
     * [Appliance](backup_vic_appliance.md)
     * [VCHs](backup_vch.md)
     * [Container Volumes](backup_volumes.md)
         * [Backing Up VMDK Volumes](backup_vmdk.md)
         * [Restoring VMDK Volumes](restore_vmdk.md)
  * [Troubleshooting](troubleshoot_vic.md) 
     * [Access and Configure Appliance Logs](appliance_logs.md)
     * [Access VCH Logs](log_bundles.md)
     * [VCH Deployment Times Out](ts_vch_deployment_timeout.md)
     * [Appliance OVF Error](ts_ovf_error.md)
     * [Certificate Verification Error](ts_thumbprint_error.md)
     * [Browser Rejects Certificates](ts_cert_error.md)
     * [Missing Common Name Error Even When TLS Options Are Specified Correctly](ts_cli_argument_error.md)
     * [Firewall Validation Error](ts_firewall_error.md)
     * [Certificate cname Mismatch](ts_cname_mismatch.md)
     * [Docker API Endpoint Check Failed Error](ts_docker_api_check_error.md)
     * [No Single Host Can Access All Datastores](ts_datastore_access_error.md)
     * [Plug-In Scripts Fail](ts_plugin_script_fails.md)
     * [Plug-In Does Not Appear](ts_ui_not_appearing.md)
     * [Some Users Cannot Access Services](ts_no_access_to_vic_services.md)
     * [Deleting or Inspecting a VCH Fails](ts_delete_inspect_error.md)
     * [Certificate Errors when Using Full TLS Authentication with Trusted Certificates](ts_clock_skew.md)
     * [Appliance VM Password Refused](ts_appliance_password_refused.md)
     * [Default Volume Store Error](ts_volume_store_error.md)
     * [Docker Login Fails](ts_dockerlogin_error.md)
  * [Security Reference](security_reference.md)
     * [Certificate Reference](vic_cert_reference.md)
     * [Obtain Appliance Certificates](obtain_appliance_certs.md)