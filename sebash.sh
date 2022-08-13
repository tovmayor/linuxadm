#!/bin/bash

#su permissions check

if [ `id -u` != 0 ]
then
    echo "Please run as su to change SELinux settings"
    exit 1
fi    

#selinux status check
reboot_needed=false
IFS=$'\n'
echo "SELinux working status: "
for s in `sestatus`
do
    if [ $s = "Current mode:                   enforcing" ]
    then
        echo -e "\tSELinux security policy is enforced\n"
        status=enforced
    
    elif [ $s = "Current mode:                   permissive" ]
    then
        echo -e "\tSELinux prints warnings instead of enforcing (permissive)\n"
        status=permissive

    elif [ $s = "SELinux status:                 disabled" ]
    then 
        echo -e "\tSELinux status: disabled\n"
        status=disabled
        reboot_needed=true
    fi

done

#parsing /etc/selinux/confug
echo -e "SELinux config file activation status: "

for c in `cat /etc/selinux/config`
do
    if [ $c = "SELINUX=enforcing" ]
    then
        echo -e "\tSELinux security policy is enforced\n"
        conf_status=enforced
    elif [ $c = "SELINUX=permissive" ]
    then
        echo -e "\tSELinux prints warnings instead of enforcing (permissive)\n"
        conf_status=permissive
    elif [ $c = "SELINUX=disabled" ]
    then
        echo -e "\tNo SELinux policy is loaded (disabled)\n"
        conf_status=disabled
    fi

done

#Changing current SELinux status
#echo -e $reboot_needed"\n"

read -p "Do you want to enable(e) or disable(d) SELinux now? " enabl
#if [[ "$enabl" == "e" && $reboot_needed ]] - don't works, wtf??
if [ "$enabl" == "e" ] && $reboot_needed
then 
    sed -i -e 's/SELINUX=disabled/SELINUX=enforcing/g' /etc/selinux/config
    echo -e "\tSELinux security policy is enforced in config file, reboot is needed."
    read -p "Do you want to reboot now? (y/n) " rn
    if [ $rn == "y" ]
    then 
        reboot now
    else
        echo $rn
        echo -e "Config already modifyed to enforce\n"
        exit 1
    fi
elif [[ "$enabl" == "e" && !$reboot_needed ]]
then 
    setenforce 1
    echo -e "\tEnabled\n"

elif [ $enabl == "d" ] && $reboot_needed
then 
    echo -e "\tAlready disbled\n"
elif [[ $enabl == "d"  && !$reboot_needed ]]
then 
    setenforce 0
    echo -e "\tDisbled\n"    
else 
    echo -e "Key not recognized, exiting \n"
    exit 1
fi

#enable SELinux in config

read -p "Do you want to enable(e) or disable(d) SELinux in config file? " conf
if [ $conf == "e" ]
then 
    sed -i -e 's/SELINUX=disabled/SELINUX=enforcing/g' /etc/selinux/config
    sed -i -e 's/SELINUX=permissive/SELINUX=enforcing/g' /etc/selinux/config
    echo -e "\tSELinux security policy is enforced in config file"
elif [ $conf == "d" ]
then 
    sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    sed -i -e 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
    echo -e "\tSELinux security policy is disabled in config file"
else 
    echo "Key not recognized, exiting \n"
    exit 1
fi