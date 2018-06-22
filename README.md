# vapi
Vultr API written in Bash. Simply place in your path and use `vapi --help` for more options and information on usage. Pretty self explanitory. Update the $API_KEY variable with your key and have fun.

# usage example:
```root@apollo:~# vapi --help
Usage: vapi --options

Options:
 -h,     --help             Help menu, provides information on usage.
 -ls,    --list-servers     List all servers and information related to account.
 -lsid,  --list-subids      List SUBID of each server.
 -lss,   --list-snapshots   List all currently available snapshots.
 -lfwr,  --list-fw-rules    List firewall rules for specified group.
 -lfwg,  --list-fw-groups   List firewall groups. To create new, use --create-fw-group.
 -cfwg,  --create-fw-group  Create new firewall group.
 -cfwr,  --create-fw-rule   Create new firewall rule.
 -css,   --create-snapshot  Create new snapshot of specified server.
 -dss,   --delete-snapshot  Destroy specified snapshot.
 -dfwr,  --delete-fw-rule   Delete specified firewallw rule.
 -dfwg,  --delete-fw-group  Delete specified firewall group.
root@apollo:~# vapi --list-fw-groups
 
     r333333333 :  
         FIREWALLGROUPID :  r333333333  
         date_created :  2018-02-16 00:23:28  
         date_modified :  2018-06-22 20:29:15  
         description :  productionweb  
         instance_count : 1 
         max_rule_count : 50 
         rule_count : 12
     
 
root@apollo:~# vapi --list-subids

         SUBID :  1010101010  
         label :  apollo  

root@apollo:~# vapi --create-snapshot
Enter SUBID of system to snapshot: 1010101010

root@apollo:~# vapi --list-snapshots
 
     3915b2d673688 :  
         APPID :  0  
         OSID :  167  
         SNAPSHOTID :  3915b2d673688  
         date_created :  2018-06-22 21:16:38  
         description :    
         size :  0  
         status :  pending 
     
root@apollo:~# vapi --list-servers
 
     10272599 :  
         APPID :  0  
         DCID :  1  
         FIREWALLGROUPID :  r333333333  
         OSID :  167  
         SUBID :  1010101010  
         VPSPLANID :  data  
         allowed_bandwidth_gb :  data  
         auto_backups :  no  
         cost_per_month :  data  
         current_bandwidth_gb : data 
         date_created :  2017-08-31 17:49:08  
         default_password :  data 
         disk :  Virtual 20 GB  
         gateway_v4 :  xxx.xxx.xxx.1  
         internal_ip :    data
         label :  apollo  
         location :  New Jersey  
         main_ip :  xxx.xxx.xxx.xxx  
         netmask_v4 :  255.255.254.0  
         os :  CentOS 7 x64  
         pending_charges :  data  
         power_status :  running  
         ram :  512 MB  
         server_state :  locked  
         status :  active  
         tag :  teamspeak  
         v6_main_ip :    
         v6_network :    
         v6_network_size :    
         v6_networks : [] 
         vcpu_count :  1 
     
 
root@apollo:~# ```
