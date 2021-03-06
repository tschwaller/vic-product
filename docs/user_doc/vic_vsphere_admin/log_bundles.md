# Access Virtual Container Host Log Bundles #

Virtual container hosts (VCHs) provide log bundles that you can download from the VCH Admin portal.

You access the VCH Admin Portal at https://<i>vch_address</i>:2378. For more information about the VCH Admin portal, see [VCH Administration Portal](access_vicadmin.md).

To aid in troubleshooting errors, you can download different log bundles:

- **Log Bundle** contains logs that relate specifically to the VCH that you created. 
- **Log Bundle with container logs** contains the logs for the VCH and also includes the logs regarding the containers that the VCH manages.

    **NOTE**: If the VCH is unable to connect to vSphere, logs that require a vSphere connection are disabled, and you see an error message. For information about accessing logs manually, see [Collecting Logs Manually](#manual) below.

Live logs (tail files) allow you to view the current status of how components are running.

- **Docker Personality** is the interface to Docker. When configured with client certificate security, it reports unauthorized access attempts to the Docker server web page.
- **Port Layer Service** is the interface to vSphere.
- **Initialization & watchdog** reports:

  - Network configuration
  - Component launch status for the other components
  - Reports component failures and restart counts

    At higher debug levels, the component output is duplicated in the log files for those components, so `init.log`  includes a superset of the log data.

    **NOTE:** This log file is duplicated on the datastore in a file in the endpoint VM folder named `tether.debug`, to allow the debugging of early stage initialization and network configuration issues.

- **Admin Server** includes logs for the VCH admin server, may contain processes that failed, and network issues. When configured with client certificate security, it reports unauthorized access attempts to the admin server web page.

Live logs can help you to see information about current commands and changes as you make them. For example, when you are troubleshooting an issue, you can see whether your command worked or failed by looking at the live logs.

You can share the non-live version of the logs with administrators or VMware Support to help you to resolve issues.

Logs also include the `vic-machine` commands used during VCH deployment to help you resolve issues.

## Collecting Logs Manually <a id="manual"></a>
If the VCH Admin portal is offline, use `vic-machine debug` to enable SSH on the VCH and use `scp -r` to capture the logs from `/var/log/vic/`.

## Setting the Log Size Cap
The log size cap is set at 20MB. If the size exceeds 20 MB, vSphere Integrated Containers Engine compresses the files and saves a history of the last two rotations. The following files are rotated:

`/var/log/vic/port-layer.log` <br>
`/var/log/vic/init.log` <br>
`/var/log/vic/docker-personality.log` <br>
`/var/log/vic/vicadmin.log`

vSphere Integrated Containers Engine logs any errors that occur during log rotation.

## Troubleshooting VCH Creation Errors ##

During a creation of a VCH, a log file named `vic-machine_<timestamp>_create_<id>.log` populates. You can find that file on the target datastore in a folder with the same name as the VCH that you specified for the `vic-machine create` command. 