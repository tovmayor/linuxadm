#!/bin/bash
#su permissions check

if [ `id -u` != 0 ]
then
    echo "Please run  as su"
    exit 1
fi    

#selinux status check

#ses=()

IFS=$'\n'
echo -en "SELinux working status: \n"
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
#        echo "Some shit"
    fi

#    echo "$s ---"
done

#parsing /etc/selinux/confug
echo -en "SELinux config file activation status: \n"

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
#        echo "Some shit"
    fi

done