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
for s in 
do
    echo "$s ---"
done