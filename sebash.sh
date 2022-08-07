#!/bin/bash
#su permissions check

if [ `id -u` != 0 ]
then
    echo "Please run  as su"
    exit 1
fi    

#selinux status check

IFS=$'\n'
echo -e "SELinux working status: "
for s in `sestatus`
do
    if [ $s = "Current mode:                   enforcing" ]
    then
        echo -e "\tSELinux security policy is enforced"
    elif [ $s = "Current mode:                   permissive" ]
    then
        echo -e "\tSELinux prints warnings instead of enforcing"
    elif [ $s = "Current mode:                   disabled" ]
    then
        echo -e "\tNo SELinux policy is loaded"
#    else 
    fi

#    echo "$s ---"
done

#enable SELinux

read -p "Do you want to enable(e) or disable(d) SELinux now?" enabl
if [ $enabl == "e" ]
then 
    setenforce 1
elif [ $enabl == "d" ]
then 
    setenforce 0
else 
    echo "Key not recognized, exiting \n"
    exit 1
fi


#parsing /etc/selinux/confug
echo -e "SELinux config file activation status: "

for c in `cat /etc/selinux/config`
do
    if [ $c = "SELINUX=enforcing" ]
    then
        echo -e "\tSELinux security policy is enforced"
    elif [ $c = "SELINUX=permissive" ]
    then
        echo -e "\tSELinux prints warnings instead of enforcing"
    elif [ $c = "SELINUX=disabled" ]
    then
        echo -e "\tNo SELinux policy is loaded"
#    else 
#        echo "Some shit happened"
    fi

done

#enable SELinux in config

read -p "Do you want to enable(e) or disable(d) SELinux in config file?" conf
if [ $conf == "e" ]
then 
    sed -i -e 's/SELINUX=disabled/SELINUX=enforcing/g' /etc/selinux/config
    echo -e "\tSELinux security policy is enforced in config file"
elif [ $conf == "d" ]
then 
    sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    echo -e "\tSELinux security policy is disabled in config file"
else 
    echo "Key not recognized, exiting \n"
    exit 1
fi