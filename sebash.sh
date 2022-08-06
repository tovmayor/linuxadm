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
for s in `sestatus`
do
    if [ $s = "Current mode:                   enforcing" ]
    then
        echo "SELinux security policy is enforced"
    elif [ $s = "Current mode:                   permissive" ]
    then
        echo "SELinux prints warnings instead of enforcing"
    elif [ $s = "Current mode:                   disabled" ]
    then
        echo "No SELinux policy is loaded"
    else 
        echo "Some shit"
    fi

#    echo "$s ---"
done