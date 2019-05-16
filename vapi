#!/bin/bash

## Vultr API written in bash, was bored and wanted to see what I could come up with.
## Change variables when needed, use https://www.vultr.com/api/ as a reference.
## Any questions about vapi contact github.com/JLH993

# Define Global Variables
DATE=$(date '+DATE: %m/%d/%y%tTIME:%H:%M:%S')
API_KEY="EnterAPIKeyHere"

## Help me?
show_help() {
echo "Usage: vapi --options"
echo ""
echo "Options:"
echo " -h,     --help             Help menu, provides information on usage."
echo " -ls,    --list-servers     List all servers and information related to account."
echo " -lsid,  --list-subids      List SUBID of each server."
echo " -ebu,   --enable-backups   Enable backups for server, must provide SUBID. (See -lsid.)"
echo " -dbu,   --disable-backups  Disable backups for server, must provide SUBID. (See -lsid.)"
echo " -lsbu,  --list-backups     List all current backups available for restore."
echo " -lsbus, --list-bu-schedule List backup schedule, must provide SUBID. (See -lsid.)"
echo " -lss,   --list-snapshots   List all currently available snapshots."
echo " -lfwr,  --list-fw-rules    List firewall rules for specified group."
echo " -lfwg,  --list-fw-groups   List firewall groups. To create new, use --create-fw-group."
echo " -cfwg,  --create-fw-group  Create new firewall group."
echo " -cfwr,  --create-fw-rule   Create new firewall rule."
echo " -css,   --create-snapshot  Create new snapshot of specified server."
echo " -dss,   --delete-snapshot  Destroy specified snapshot."
echo " -dfwr,  --delete-fw-rule   Delete specified firewallw rule."
echo " -dfwg,  --delete-fw-group  Delete specified firewall group."
}

#####################
## Server options...#
#####################
server_list() {
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/server/list | python -mjson.tool | grep -v "kvm" | tr '"' ' ' | tr ',' ' ' | tr '{}' ' '
}

server_listsid() {
echo "" && curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/server/list | python -mjson.tool | tr '"' ' ' | tr ',' ' ' | tr '{}' ' ' | grep -e "SUBID" -e "label" && echo ""
}

server_enablebackup() {
echo -n "Please enter SUBID of server to enable backups: "
read BKUPID
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/server/backup_enable --data 'SUBID=$BKUPID' | python -mjson.tool | tr '"' ' ' | tr ',' ' ' | tr '{}' ' '
}

server_disablebackup() {
echo -n "Please enter SUBID of server to disable backups on: "
read DBKUPID
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/server/backup_disable --data 'SUBID=$DBKUPID' | python -mjson.tool | tr '"' ' ' | tr ',' ' ' | tr '{}' ' '
}

server_backupls() {
url -sH "API-Key: $API_KEY" https://api.vultr.com/v1/backup/list | python -mjson.tool | tr '"' ' ' | tr ',' ' ' | tr '{}' ' '
}

getbackupschedule() {
echo -n "Please enter SUBID of server to view backup schedule for: "
read SCHID
curl -sH "API-Key: 67EVK5Z4ORABAATPJCVXZFUQOLIU6MX3DPMA" https://api.vultr.com/v1/server/backup_get_schedule --data 'SUBID=$SCHID' | python -mjson.tool | tr '"' ' ' | tr ',' ' ' | tr '{}' ' '
}

#######################
## Firewall options...#
#######################
firewall_grouplist() {
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/firewall/group_list | python -mjson.tool | tr '"' ' ' | tr ',' ' ' | tr '{}' ' '
}

firewall_groupcreate() {
echo -n "Enter new group name: "
read NG
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/firewall/group_create --data "description=$NG" && echo ""
}

firewall_groupdelete() {
echo -n "Enter fw group id to destroy: "
read FWG
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/firewall/group_delete --data "FIREWALLGROUPID=$FWG"
}

firewall_rulelist() {
echo -n "Enter firewall group to view fw rules for: "
read FWG
curl -sH "API-Key: $API_KEY" "https://api.vultr.com/v1/firewall/rule_list?FIREWALLGROUPID=$FWG&direction=in&ip_type=v4" | python -mjson.tool | tr '"' ' ' | tr ',' ' ' | tr '{}' ' '
}

firewall_rulecreate() {
echo "Creating new fw rule, please input information..."
echo -n "Enter firewall group to add rule to: "
read FWGID
echo -n "Enter IP type [v4/v6]: "
read IPT
echo -n "Enter protocol [tcp/udp]: "
read PROTO
echo -n "Enter source IP: "
read SIP
echo -n "Enter subnet size [16/24/32]: "
read SUBNET
echo -n "Enter port: "
read PORT
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/firewall/rule_create --data "FIREWALLGROUPID=$FWGID" --data "direction=in" --data "ip_type=$IPT" --data "protocol=$PROTO" --data "subnet=$SIP" --data "subnet_size=$SUBNET" --data "port=$PORT" && echo ""
}

firewall_ruledelete() {
echo -n "Enter fw group rule lives in: "
read FWG
echo -n "Enter rule number: "
read RN
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/firewall/rule_delete --data "FIREWALLGROUPID=$FWG" --data "rulenumber=$RN" && echo "Rule $RN deleted."
}

#######################
## Snapshot options...#
#######################
snapshot_create() {
echo -n "Enter SUBID of system to snapshot: "
read SID
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/snapshot/create --data "SUBID=$SID"
}

snapshot_destroy() {
echo -n "Enter snapshot ID: "
read SSID
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/snapshot/destroy --data "SNAPSHOTID=$SSID" && echo "Snapshot $SSID delete action sent." && echo ""
}

snapshot_list() {
curl -sH "API-Key: $API_KEY" https://api.vultr.com/v1/snapshot/list | python -mjson.tool | grep -v "kvm" | tr '"' ' ' | tr ',' ' ' | tr '{}' ' ' && echo ""
}


# All command args, use --help or -h for help and usage.
case $1 in
	""|"-h"|"--help") show_help ;;
	"--list-servers"|"--listserv"|"-ls") server_list ;;
	"--list-subids"|"--listsid"|"-lsid") server_listsid ;;
	"--enable-backups"|"--enablebu"|"-ebu") server_enablebackup ;;
	"--disable-backups"|"--disablebu"|"-dbu") server_disablebackup ;;
	"--list-backups"|"--listbu"|"-lsbu") server_backupls ;;
	"--list-bu-schedule"|"--listbus"|"-lsbus") getbackupschedule ;;
	"--list-snapshots"|"--listss"|"-lss") snapshot_list ;;
	"--list-fw-rules"|"--listfwr"|"-lfwr") firewall_rulelist ;;
	"--list-fw-groups"|"--listfwg"|"-lfwg") firewall_grouplist ;;
	"--create-fw-group"|"--createfwg"|"-cfwg") firewall_groupcreate ;;
	"--create-fw-rule"|"--createfwr"|"-cfwr") firewall_rulecreate ;;
	"--create-snapshot"|"--createss"|"-css") snapshot_create ;;
	"--delete-snapshot"|"--deletess"|"-dss") snapshot_destroy ;;
	"--delete-fw-rule"|"--deletefwr"|"-dfwr") firewall_ruledelete ;;
	"--delete-fw-group"|"--deletefwg"|"-dfwg") firewall_groupdelete ;;
esac
